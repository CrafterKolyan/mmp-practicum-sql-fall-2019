#!/usr/bin/python3

import MySQLdb
import os
import re

TOTAL_TASKS = 6
PROJECT_DIRECTORY = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def is_similar_queries(connection, sql_query1, sql_query2):
	cursor = connection.cursor()
	print(sql_query1)
	print(sql_query2)
	query = f"{sql_query1}\n MINUS\n {sql_query2}"
	print(query)
	cursor.execute(f"{sql_query1}\n MINUS\n {sql_query2}")
	# cursor.execute(f"SELECT COUNT(*) FROM (({sql_query1} MINUS {sql_query2}) UNION ALL ({sql_query2} MINUS {sql_query1})) AS intersected_query")
	row = cursor.fetchall()
	print(row)
	cursor.close()
	return False

connection = MySQLdb.connect(host = "trjudge.cs.msu.ru",
                             user = "demo",
                             passwd = "demo",
                             db = "srcdt",
                             charset = "utf8")


for i in range(TOTAL_TASKS):
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
		for file in files:
			if re_files.fullmatch(file):
				with open(os.path.join(folder, file)) as f:
					sql_queries.append("".join(f.readlines()).replace(';', ''))
		for sql_query in sql_queries:
			is_similar_queries(connection, sql_query, sql_queries[0])
		total_files += len(sql_queries)
		subtask_number += 1
		break
	break


connection.close()