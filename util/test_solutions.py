#!/usr/bin/python3

import MySQLdb
import os
import re
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed

TOTAL_TASKS = 6
PROJECT_DIRECTORY = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MAX_WORKERS = 20

def get_sql_result(connection, sql_query):
    cursor = connection.cursor()
    cursor.execute(sql_query)
    row = cursor.fetchall()
    cursor.close()
    return row

connection = MySQLdb.connect(host = "trjudge.cs.msu.ru",
                             user = "demo",
                             passwd = "demo",
                             db = "srcdt",
                             charset = "utf8")


for i in range(2, TOTAL_TASKS):
    folder = os.path.join(PROJECT_DIRECTORY, f"task{i}")
    if not os.path.exists(folder):
        continue
    subtask_number = 1
    files = sorted(os.listdir(folder))
    total_files = 0
    while total_files < len(files):
        re_files = re.compile(fr"[A-Z][a-z]*_{i}_{subtask_number}\.sql")
        anyFile = False
        sql_queries = []
        current_files = []
        for file in files:
            if re_files.fullmatch(file):
                current_files.append(file)
                with open(os.path.join(folder, file), 'r', encoding='utf-8') as f:
                    sql_queries.append("".join(f.readlines()).replace(';', ''))
        groups = {}
        print(f"Fetching...", end="\r")
        with ThreadPoolExecutor(max_workers=MAX_WORKERS) as executor:
            results = {executor.submit(get_sql_result, connection, sql_query): filename for sql_query, filename in zip(sql_queries, current_files)}
            try: 
                for future_result in as_completed(results):
                    filename = results[future_result]
                    try:
                        result = future_result.result()
                    except Exception as e:
                        print(f"{filename} -> Exception: {e}")
                    else:
                        print(" " * 50, end="\r")
                        print(f"Fetched {filename}", end="\r")
                        filenames = groups.get(result, [])
                        filenames.append(filename)
                        groups[result] = filenames
            except BaseException as e:
                print("Cancelling jobs")
                for result in results:
                    if not result.running():
                        result.cancel()
                sys.exit(0)
        print(" " * 50, end="\r")
        if len(groups) > 1:
            print(f"{i}.{subtask_number} -> ERROR!")
            for group_num, x in enumerate(groups):
                print(f"Group {group_num + 1} ({len(x)} rows, first row: {list(x[0])}):")
                for user in groups[x]:
                    print(f"\t{user[:user.find('_')]}")
        elif len(groups) == 1:
            print(f"{i}.{subtask_number} -> OK")
        total_files += len(sql_queries)
        subtask_number += 1
    break


connection.close()