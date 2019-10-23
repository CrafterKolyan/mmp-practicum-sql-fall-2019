#!/usr/bin/python3

import MySQLdb
import sys
from modules.taskinfo import TaskInfo

exit_code = 0

connection = MySQLdb.connect(host = "localhost",
                             user = "root",
                             passwd = "root",
                             db = "srcdt",
                             charset = "utf8")

tasks = [
    TaskInfo(4, 1, skip=False, ordered=True),
    TaskInfo(4, 2, skip=False, ordered=False),
    TaskInfo(4, 3, skip=False, ordered=False, valid_for='day'),

    TaskInfo(1, 1, skip=True, ordered=False),
    TaskInfo(1, 2, skip=True, ordered=False),
    TaskInfo(1, 3, skip=True, ordered=True),

    TaskInfo(2, 1, skip=True, ordered=False),
    TaskInfo(2, 2, skip=True, ordered=False),
    TaskInfo(2, 3, skip=True, ordered=True, valid_for='day'),

    TaskInfo(3, 1, skip=True, ordered=False),
    TaskInfo(3, 2, skip=True, ordered=False, valid_for='day'),
    TaskInfo(3, 3, skip=True, ordered=False),
]

for task in tasks:
    if not task.test(connection, verbose=1):
        exit_code = 1

connection.close()
sys.exit(exit_code)
