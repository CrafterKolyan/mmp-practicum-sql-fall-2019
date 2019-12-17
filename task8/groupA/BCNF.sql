DROP TABLE IF EXISTS bcnf_users, bcnf_groups, bcnf_user_group, bcnf_assignment, bcnf_tasks, bcnf_solutions, bcnf_grades;

CREATE TABLE IF NOT EXISTS bcnf_users
(
    login VARCHAR(40) NOT NULL UNIQUE,
    first_name VARCHAR(120),
    last_name VARCHAR(120),
    middle_name VARCHAR(120),
    password_hash VARCHAR(120) NOT NULL,
    password_salt CHARACTER(12) NOT NULL,
    active TINYINT(1) NOT NULL,
    super_user TINYINT(1) NOT NULL,
    PRIMARY KEY(login)
) AS 
SELECT login, `name` AS first_name, last_name, middle_name, password_hash, password_salt, active, super_user FROM junk_users;

CREATE TABLE IF NOT EXISTS bcnf_groups
(
    group_id INT NOT NULL UNIQUE,
    discipline VARCHAR(120),
    PRIMARY KEY(group_id)
) AS
SELECT group_key AS group_id, discipline FROM junk_groups;

CREATE TABLE IF NOT EXISTS bcnf_user_group
(
    login VARCHAR(40) NOT NULL,
    group_id INT NOT NULL,
    tutor TINYINT(1) NOT NULL,
    alias VARCHAR(120) NOT NULL,
    PRIMARY KEY(login, group_id),
    
    FOREIGN KEY (login)
        REFERENCES bcnf_users(login)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (group_id)
        REFERENCES bcnf_groups(group_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) AS
SELECT student_login AS login, group_key AS group_id, 0 AS tutor, student_login AS alias FROM junk_students;

INSERT INTO bcnf_user_group
SELECT tutor_login AS login, group_key AS group_id, 1 AS tutor, tutor_login AS alias FROM junk_tutors;

CREATE TABLE IF NOT EXISTS bcnf_assignment
(
    assignment_id INT NOT NULL UNIQUE,
    author VARCHAR(40) NOT NULL,
    group_id INT NOT NULL,
    `text` VARCHAR(1000) NOT NULL,
    deadline TIMESTAMP NOT NULL,
    PRIMARY KEY(assignment_id),
    
    FOREIGN KEY (author)
        REFERENCES bcnf_users(login)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (group_id)
        REFERENCES bcnf_groups(group_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) AS
SELECT assignment_id, author, deadline, group_key AS group_id, `text` FROM junk_assignments;

CREATE TABLE IF NOT EXISTS bcnf_tasks
(
    task_id INT NOT NULL UNIQUE,
    assignment_id INT NOT NULL,
    `text` VARCHAR(1000) NOT NULL,
    PRIMARY KEY(task_id),
    
    FOREIGN KEY (assignment_id)
        REFERENCES bcnf_assignment(assignment_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) AS
SELECT assignment_id, task_id, `text` FROM junk_tasks;

CREATE TABLE IF NOT EXISTS bcnf_solutions
(
    student VARCHAR(40) NOT NULL,
    task_id INT NOT NULL,
    `text` VARCHAR(1000) NOT NULL,
    submission_datetime TIMESTAMP NOT NULL,
    PRIMARY KEY(task_id, student),
    
    FOREIGN KEY (task_id)
        REFERENCES bcnf_tasks(task_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (student)
        REFERENCES bcnf_users(login)
        ON UPDATE CASCADE ON DELETE RESTRICT
) AS
SELECT task_id, student, `text`, `date` AS submission_datetime FROM junk_solutions;

CREATE TABLE IF NOT EXISTS bcnf_grades
(
    grader VARCHAR(40) NOT NULL,
    student VARCHAR(40) NOT NULL,
    task_id INT NOT NULL,
    grade_datetime TIMESTAMP NOT NULL,
    `comment` VARCHAR(1000) NOT NULL,
    grade INT NOT NULL,
    PRIMARY KEY(grader, student, task_id, grade_datetime),
    
    FOREIGN KEY (task_id)
        REFERENCES bcnf_tasks(task_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (student)
        REFERENCES bcnf_solutions(student)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (grader)
        REFERENCES bcnf_users(login)
        ON UPDATE CASCADE ON DELETE RESTRICT
) AS
SELECT `date` AS grade_datetime, grader, student, task_id, `comment`, grade FROM junk_grades;

