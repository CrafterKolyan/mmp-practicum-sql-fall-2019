# Система сдачи заданий для практикума по SQL

Действует автоматическая система тестирования:  
[Результаты тестирования](https://github.com/CrafterKolyan/mmp-practicum-sql-fall-2019/actions?query=workflow%3ATests+branch%3Amaster)

## Сроки сдачи заданий

| Задание     | Дата сдачи |
| :---------: |:-----------|
| [Задание 1](https://docs.google.com/presentation/d/e/2PACX-1vREydAsh-XzoT16zOpMLcVYd60Gk19jdUnqoWpTdRPiXzFbMzf_5Me1v1tpKs2RO5IjZMOxnTtlBo7M/pub?start=false&loop=false&delayms=3000&slide=id.g4d1ad25642_0_6) | 2 октября |
| [Задание 2](https://docs.google.com/presentation/d/e/2PACX-1vTipIHg0wEZR7bRMI_FpaWBvQwG_s7vgha6TLhU6WAbUYXDH-Ice199129o6Dv8ffNc4ocEVKGsY7tX/pub?start=false&loop=false&delayms=3000&slide=id.p) | 9 октября |
| [Задание 3](https://docs.google.com/presentation/d/e/2PACX-1vRCoUr_QIUPG4k52Yzh_3nk86jCAmTuFUjU7iJG4B_gwrcGQdtI0IAAu_BtxIwLlJrvSSGzt-8C1JM9/pub?start=false&loop=false&delayms=3000&slide=id.p) | 16 октября |
| [Advanced Pandas 1](https://github.com/eugenbobrov/advanced-pandas/blob/master/hw-1-advanced-pandas/hw-1-advanced-pandas.ipynb) | 18 октября 23:59 (мягкий) / 25 октября 23:59 (жёсткий) |
| [Задание 4](https://docs.google.com/presentation/d/e/2PACX-1vR1bW9uvE6QSb5u5q7jzTC_TiVts654K0_lY6FB7VCgOiBRf45x-01LG7S23WWSjA_UwBX8P3RDodlN/pub?start=false&loop=false&delayms=3000&slide=id.g17340f7805_0_0) | 23 октября |
| [Advanced Pandas 2](https://github.com/eugenbobrov/advanced-pandas/blob/master/hw-2-advanced-pandas/hw-2-advanced-pandas.ipynb) | 25 октября 23:59 (мягкий) / 1 ноября 23:59 (жёсткий) |
| [Задание 7](https://docs.google.com/presentation/d/e/2PACX-1vRWEPitNNp3rswV3l07EKCMOuEu9MIiV0yBnS5GgtESkBA8tbnrKGiadJH11HGoup7tnpB-2Ydt0OFd/pub?start=false&loop=false&delayms=3000) | 4 декабря |
| [Задание 8](https://docs.google.com/presentation/d/e/2PACX-1vSU7Tf1yeisRbXSkZ4nPkmJEYeK4PYu24Rhc5iyA05G-RhGu5uXXiWvDtzsriAR1VXv68amT6Gk0GDq/pub?start=false&loop=false&delayms=3000) | 11 декабря |


## Куда сдавать задания
В папки `task1`, `task2`, ..., `task4` в формате `<Фамилия>_<номер задачи>_<номер подзадачи>.sql`, например `task2/Kormakov_2_1.sql`.
Совпадение номера задачи и номера папки обязательно (иначе система не примет).
Также есть система защиты от других студентов, Ваши файлы сможете изменить только Вы (и я).
Доступ на создание папок `task1`, `task2`, ..., `task4` у всех есть.

## Как сдать задание
0. Написать Крафтеру свой github и фамилию на английском языке
1. Сделать fork репозитория
2. Сделать commit (изменения) в **свой fork** репозиторий (можно, как создать ветку, так и просто пихать всё в `master`)
3. Сделать pull request своей ветки в `master` репозитория Крафтерa  
**_Дополнительно: можно заставить бота принимать pull request относительно быстро (читай FAQ)_**

## FAQ
Тут я постараюсь разобрать сложные кейсы, которые могут у Вас возникнуть с Git'ом, но вообще они гуглятся.
На некоторые вопросы ответов не будет, пока у меня не дойдут руки до того, чтобы написать их.
Если Ваш вопрос есть в FAQ, но на него не написан ответ, можете написать мне я отвечу.

### Как заставить бота принимать pull request быстрее (за 20 секунд, а не за 3 минуты)?
Необходимо засылать цепочку `commit`'ов, которая растёт от текущего `master` репозитория Крафтера.
Чтобы перекинуть свою текущую цепочку `commit`'ов на `master` обновлённой версии репозитория, можно выполнить последовательность команд из вопроса ниже.

### Бот не принимает мой pull request, хотя я изменял(а) только свои файлы. Что делать?
Скорее всего, достаточно обновиться до новой версии репозитория и перенести свои изменения туда. Смотри вопрос ниже.

### Почему в моём fork репозитории не появляются изменения других людей? Как это исправить?
Чтобы появились обновления от других людей, нужно обновиться до новой версии репозитория.  
Один из вариантов (нужно находиться на ветке `master` (которая совпадает с `origin/master`)):
```
git remote add root https://github.com/CrafterKolyan/mmp-practicum-sql-fall-2019.git
git fetch -p root
git stash
git rebase root/master
git stash pop
```
В случае возникновения ошибки `rebase`'a:
```
git rebase --abort
git stash pop
```
Если всё успешно, то ничего ещё не изменено на сервере, так что можно **проверить, что все ваши изменения никуда не делись** и Вас всё устраивает.  
Если всё устраивает:
```
git push origin --force-with-lease
```
Можно дополнительно убрать добавленный `remote`:
```
git remote remove root
```
Если не устраивает:
```
git reset --soft origin/master
```
