import re
import os
import time
import sys
from multiset import FrozenMultiset
from .cache_manager import *

def get_sql_result(connection, sql_query):
    cursor = connection.cursor()
    cursor.execute(sql_query)
    row = cursor.fetchall()
    cursor.close()
    return row


class TaskInfo:
    __slots__ = ['task', 'subtask', 'ordered', 'skip', 'valid_for']

    def __init__(self, task, subtask, skip=False, ordered=False, valid_for=None):
        self.task = task
        self.subtask = subtask
        self.skip = skip
        self.ordered = ordered
        self.valid_for = valid_for

    def get_folder(self):
        project_directory = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
        return os.path.join(project_directory, f"task{self.task}")

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
                if file == "Chernyshev_3_2.sql" or file == "Tashevtsev_3_2.sql":
                    continue
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
        hash_to_info = {}

        for sql_query, filename in zip(sql_queries, files):
            result = get_cached_query(filename, sql_query)
            if result:
                print(f"Using cached {filename}")
                key = result['hash']
                filenames = groups.get(key, [])
                filenames.append(filename)
                groups[key] = filenames

                if hash_to_info.get(key, None) is None:
                    hash_to_info[key] = {'data': result['data'], 'len': result['rows']}
                continue
            print(f"Fetching {filename}", end=" ")
            sys.stdout.flush()
            start_time = time.perf_counter()
            try:
                result = get_sql_result(connection, sql_query)
                if not self.ordered:
                    result = tuple(sorted(result))
            except Exception as e:
                print(f"{filename} -> Exception: {e}")
                success = False
            else:
                set_cached_query(filename, sql_query, result, self.valid_for)
                key = hash(result)
                filenames = groups.get(key, [])
                hash_to_info[key] = {'data': result, 'len': len(result)}
                filenames.append(filename)
                groups[key] = filenames
            end_time = time.perf_counter()
            print(f"Time: {end_time - start_time} s")
        
        if len(groups) > 0:
            print("-" * 25)
        if len(groups) > 1:
            success = False
            print(f"{self.task}.{self.subtask} -> ERROR!")
            for group_num, x in enumerate(groups):
                info = hash_to_info[x]
                first_row = self.get_first_row(info['data'])
                print(f"Group {group_num + 1} ({info['len']} rows, first row: {list(first_row)}):")
                for user in groups[x]:
                    print(f"\t{user[:user.find('_')]}")
        elif len(groups) == 1:
            for x in groups:
                info = hash_to_info[x]
                first_row = self.get_first_row(info['data'])
                break
            print(f"{self.task}.{self.subtask} -> OK ({info['len']} rows, first row: {list(first_row)})")
        if len(groups) > 0:
            print("-" * 25)
        sys.stdout.flush()
        return success