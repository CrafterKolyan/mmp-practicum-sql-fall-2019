#!/usr/bin/python3

import subprocess
import os
import re
import sys
import json


user = os.environ.get('GITHUB_ACTOR', None)
if not user:
    print(f"Нету переменной среды 'GITHUB_ACTOR'")
    sys.exit(1)

directory = os.path.abspath(os.path.dirname(__file__))
with open(f'{directory}/users.json') as users:
    users_to_rights = json.load(users)

surname = users_to_rights.get(user, None)
if not surname:
    print(f"Пользователь '{user}' не имеет прав писать в данный репозиторий")
    sys.exit(1)

surnames_re_text = fr'(?:{"|".join(surname)})'
re_task_files = re.compile(fr'task([1-47-8])/{surnames_re_text}_\1_\d\.sql|hw[12]-advanced-pandas/{surnames_re_text}\.ipynb')

file_diff = subprocess.check_output(["git", "diff", "origin/master", "--name-only"]).decode('utf-8').split('\n')
file_diff = file_diff[:-1]

for file in file_diff:
    if not re_task_files.fullmatch(file):
        print(f"Отсутствие прав у пользователя '{user}' на изменение '{file}'")
        sys.exit(1)
