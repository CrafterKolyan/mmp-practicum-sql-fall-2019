#!/usr/bin/python3

import MySQLdb
import os
import re
import sys
import time

PROJECT_DIRECTORY = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
exit_code = 0

def get_sql_result(connection, sql_query):
    cursor = connection.cursor()
    cursor.execute(sql_query)
    row = cursor.fetchall()
    cursor.close()
    return row


class TaskInfo:
    __slots__ = ['task', 'subtask', 'ordered', 'skip']

    def __init__(self, task, subtask, skip=False, ordered=False):
        self.task = task
        self.subtask = subtask
        self.skip = skip
        self.ordered = ordered

    def get_folder(self):
        return os.path.join(PROJECT_DIRECTORY, f"task{self.task}")

    def get_file_regex(self):
        return re.compile(fr"[A-Z][a-z]*_{self.task}_{self.subtask}\.sql")

    def get_files(self):
        folder = self.get_folder()
        if not os.path.exists(folder):
            return []
        all_files = sorted(os.listdir(folder))
        re_files = self.get_file_regex()
        files = []
        for file in all_files:
            if re_files.fullmatch(file):
                files.append(file)
        return files

    def get_first_row(self, table):
        if self.ordered:
            return table[0]
        for first_row in sorted(table):
            return first_row
        return []

    def test(self, connection, verbose=1):
        success = True
        if self.skip:
            return success
        folder = self.get_folder()
        sql_queries = []
        files = self.get_files()
        for file in files:
            with open(os.path.join(folder, file), 'r', encoding='utf-8') as f:
                sql_queries.append("".join(f.readlines()).replace(';', ''))

        groups = {}
        for sql_query, filename in zip(sql_queries, files):
            print(f"Fetching {filename}", end=" ")
            sys.stdout.flush()
            start_time = time.perf_counter()
            try:
                result = get_sql_result(connection, sql_query)
                if not self.ordered:
                    result = frozenset(result)
            except Exception as e:
                print(f"{filename} -> Exception: {e}")
                success = False 
            else:
                filenames = groups.get(result, [])
                filenames.append(filename)
                groups[result] = filenames
            end_time = time.perf_counter()
            print(f"Time: {end_time - start_time} s")
        
        if len(groups) > 1:
            success = False
            print(f"{self.task}.{self.subtask} -> ERROR!")
            for group_num, x in enumerate(groups):
                first_row = self.get_first_row(x)
                print(f"Group {group_num + 1} ({len(x)} rows, first row: {list(first_row)}):")
                for user in groups[x]:
                    print(f"\t{user[:user.find('_')]}")
        elif len(groups) == 1:
            for x in groups:
                first_row = self.get_first_row(x)
                break
            print(f"{self.task}.{self.subtask} -> OK ({len(x)} rows, first row: {list(first_row)})")
        sys.stdout.flush()
        return success


connection = MySQLdb.connect(host = "trjudge.cs.msu.ru",
                             user = "demo",
                             passwd = "demo",
                             db = "srcdt",
                             charset = "utf8")

tasks = [
    TaskInfo(1, 1, skip=True, ordered=False),
    TaskInfo(1, 2, skip=True, ordered=False),
    TaskInfo(1, 3, skip=True, ordered=True),

    TaskInfo(2, 1, skip=True, ordered=False),
    TaskInfo(2, 2, skip=True, ordered=False),
    TaskInfo(2, 3, skip=True, ordered=True),

    TaskInfo(3, 1, skip=True, ordered=False),
    TaskInfo(3, 2, skip=False, ordered=False),
    TaskInfo(3, 3, skip=False, ordered=False),

    TaskInfo(4, 1, skip=False, ordered=True),
    TaskInfo(4, 2, skip=False, ordered=False),
    TaskInfo(4, 3, skip=False, ordered=False)
]

for task in tasks:
    if not task.test(connection, verbose=1):
        exit_code = 1

connection.close()
sys.exit(exit_code)
