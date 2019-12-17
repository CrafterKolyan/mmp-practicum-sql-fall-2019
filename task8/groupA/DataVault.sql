DROP TABLE IF EXISTS datavault_assignment_group_link,
                     datavault_assignment_hub,
                     datavault_assignment_satellite,
                     datavault_grade_hub,
                     datavault_grade_satellite,
                     datavault_grade_solution_link,
                     datavault_grade_user_link,
                     datavault_group_hub,
                     datavault_group_satellite,
                     datavault_solution_assignment_link,
                     datavault_solution_hub,
                     datavault_solution_satellite,
                     datavault_task_assignment_link,
                     datavault_task_hub,
                     datavault_task_satellite,
                     datavault_user_assignment_link,
                     datavault_user_group_link,
                     datavault_user_group_satellite,
                     datavault_user_hub,
                     datavault_user_satellite,
                     datavault_user_solution_link;

CREATE TABLE IF NOT EXISTS datavault_user_hub
(
    user_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(user_key)
);

CREATE TABLE IF NOT EXISTS datavault_user_satellite
(
    user_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    login VARCHAR(40) NOT NULL,
    first_name VARCHAR(120),
    last_name VARCHAR(120),
    middle_name VARCHAR(120),
    password_hash VARCHAR(120) NOT NULL,
    password_salt CHARACTER(12),
    active TINYINT(1),
    super_user TINYINT(1),
    PRIMARY KEY(user_key, LoadDTS)
) AS
SELECT
    "junk" AS ResSrc,
    login,
    NAME AS first_name,
    last_name,
    middle_name,
    password_hash,
    password_salt,
    active,
    super_user
FROM junk_users;

CREATE TABLE IF NOT EXISTS datavault_group_satellite
(
    group_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    discipline VARCHAR(120),
    PRIMARY KEY(group_key, LoadDTS)
) AS 
SELECT
    "junk" AS ResSrc,
    discipline
FROM junk_groups;

CREATE TABLE IF NOT EXISTS datavault_user_group_satellite
(
    user_group_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    tutor TINYINT(1) NOT NULL,
    alias VARCHAR(120),
    PRIMARY KEY(user_group_key, LoadDTS)
);

CREATE TABLE IF NOT EXISTS datavault_assignment_satellite
(
    assignment_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    `text` VARCHAR(1000),
    deadline DATETIME NOT NULL,
    PRIMARY KEY(assignment_key, LoadDTS)
) AS
SELECT
    assignment_id AS assignment_key,
    "junk" AS ResSrc,
    `text`,
    deadline
FROM junk_assignments;

CREATE TABLE IF NOT EXISTS datavault_task_satellite
(
    task_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    `text` VARCHAR(1000),
    PRIMARY KEY(task_key, LoadDTS)
) AS
SELECT
    task_id as task_key,
    "junk" AS ResSrc,
    `text`
FROM junk_tasks;

CREATE TABLE IF NOT EXISTS datavault_grade_satellite
(
    grade_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    `comment` VARCHAR(1000) NOT NULL,
    grade INT NOT NULL,
    PRIMARY KEY(grade_key, LoadDTS)
) AS
SELECT
    grade_id AS grade_key,
    "junk" AS ResSrc,
    `text`
FROM junk_tasks;

CREATE TABLE IF NOT EXISTS datavault_group_hub
(
    group_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(group_key)
);

CREATE TABLE IF NOT EXISTS datavault_assignment_hub
(
    assignment_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(assignment_key)
);

CREATE TABLE IF NOT EXISTS datavault_task_hub
(
    task_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(task_key)
);

CREATE TABLE IF NOT EXISTS datavault_solution_hub
(
    solution_key INT NOT NULL AUTO_INCREMENT,
    ResSrc VARCHAR(40),
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(solution_key)
);

CREATE TABLE IF NOT EXISTS datavault_grade_hub
(
    grade_key INT NOT NULL AUTO_INCREMENT,
    ResSrc VARCHAR(40),
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(grade_key)
);

CREATE TABLE IF NOT EXISTS datavault_user_group_link
(
    user_group_key INT NOT NULL AUTO_INCREMENT,
    user_key INT NOT NULL,
    group_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(user_group_key)
);

CREATE TABLE IF NOT EXISTS datavault_solution_satellite
(
    solution_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    TEXT VARCHAR(1000),
    submission_datetime DATETIME,
    PRIMARY KEY(solution_key, LoadDTS)
);

# Group - Assignment

CREATE TABLE IF NOT EXISTS datavault_assignment_group_link
(
    assignment_group_key INT NOT NULL AUTO_INCREMENT,
    assignment_key INT NOT NULL,
    group_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(assignment_group_key)
) AS 
SELECT 
group_key, 
assignment_id AS assignment_key 
FROM junk_assignments;

# Task - Assignment

CREATE TABLE IF NOT EXISTS datavault_task_assignment_link
(
    task_assignment_key INT NOT NULL AUTO_INCREMENT,
    task_key INT NOT NULL,
    assignment_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(task_assignment_key)
) AS 
SELECT 
task_key, 
assignment_id AS assignment_key 
FROM junk_tasks;

# User - Assignment

CREATE TABLE IF NOT EXISTS datavault_user_assignment_link
(
    user_assignment_key INT NOT NULL AUTO_INCREMENT,
    user_key INT NOT NULL,
    assignment_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(user_assignment_key)
) AS 
SELECT 
user_key, 
assignment_id AS assignment_key 
FROM junk_assignments AS assignments JOIN datavault_user_satellite AS users
ON users.login = assignments.author;

# User - Solution

CREATE TABLE IF NOT EXISTS datavault_user_solution_link
(
    user_solution_key INT NOT NULL AUTO_INCREMENT,
    user_key INT NOT NULL,
    solution_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(user_solution_key)
) AS 
SELECT 
user_key, 
solution_id AS solution_key 
FROM junk_solutions AS solutions JOIN datavault_user_satellite AS users
ON users.login = solutions.student;

# Grade - User

CREATE TABLE IF NOT EXISTS datavault_grade_user_link
(
    grade_user_key INT NOT NULL AUTO_INCREMENT,
    grade_key INT NOT NULL,
    user_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(grade_user_key)
) AS 
SELECT 
user_key, 
grade_id AS grade_key 
FROM junk_grades AS grades JOIN datavault_user_satellite AS users
ON users.login = grades.grader;

# Solution - Task
CREATE TABLE IF NOT EXISTS datavault_solution_task_link
(
    solution_task_key INT NOT NULL AUTO_INCREMENT,
    solution_key INT NOT NULL,
    task_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(solution_task_key)
) AS 
SELECT 
solution_id AS solutions_key, 
task_id AS task_key 
FROM junk_solutions

INSERT INTO datavault_user_hub
SELECT user_key, ResSrc FROM datavault_user_satellite;

INSERT INTO datavault_assignment_hub
SELECT assignment_key, ResSrc FROM datavault_assignment_satellite;

INSERT INTO datavault_grade_hub
SELECT grade_key, ResSrc FROM datavault_grade_satellite;

INSERT INTO datavault_solution_hub
SELECT solution_key, ResSrc FROM datavault_solution_satellite;

INSERT INTO datavault_task_hub
SELECT task_key, ResSrc FROM datavault_task_satellite;

INSERT INTO datavault_group_hub
SELECT group_key, ResSrc FROM datavault_group_satellite;

ALTER TABLE datavault_user_satellite
ADD FOREIGN KEY (user_key)
REFERENCES datavault_user_hub(user_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_user_group_link
ADD FOREIGN KEY (group_key)
REFERENCES datavault_group_hub(group_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_assignment_group_link
ADD FOREIGN KEY (assignment_key)
REFERENCES datavault_assignment_hub(assignment_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_assignment_group_link
ADD FOREIGN KEY (group_key)
REFERENCES datavault_group_hub(group_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_user_group_satellite
ADD FOREIGN KEY (user_group_key)
REFERENCES datavault_user_group_link(user_group_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_user_group_link
ADD FOREIGN KEY (user_key)
REFERENCES datavault_user_hub(user_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_user_satellite
ADD FOREIGN KEY (user_key)
REFERENCES datavault_user_hub(user_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_assignment_satellite
ADD FOREIGN KEY (assignment_key)
REFERENCES datavault_assignment_hub(assignment_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_user_assignment_link
ADD FOREIGN KEY (assignment_key)
REFERENCES datavault_assignment_hub(assignment_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_user_assignment_link
ADD FOREIGN KEY (user_key)
REFERENCES datavault_user_hub(user_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_task_satellite
ADD FOREIGN KEY (task_key)
REFERENCES datavault_task_hub(task_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_task_assignment_link
ADD FOREIGN KEY (assignment_key)
REFERENCES datavault_assignment_hub(assignment_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_task_assignment_link
ADD FOREIGN KEY (task_key)
REFERENCES datavault_task_hub(task_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_solution_satellite
ADD FOREIGN KEY (solution_key)
REFERENCES datavault_solution_hub(solution_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_solution_task_link
ADD FOREIGN KEY (task_key)
REFERENCES datavault_task_hub(task_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_solution_task_link
ADD FOREIGN KEY (solution_key)
REFERENCES datavault_solution_hub(solution_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_user_solution_link
ADD FOREIGN KEY (user_key)
REFERENCES datavault_user_hub(user_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_user_solution_link
ADD FOREIGN KEY (solution_key)
REFERENCES datavault_solution_hub(solution_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_grade_satellite
ADD FOREIGN KEY (grade_key)
REFERENCES datavault_grade_hub(grade_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_grade_solution_link
ADD FOREIGN KEY (solution_key)
REFERENCES datavault_solution_hub(solution_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_grade_solution_link
ADD FOREIGN KEY (grade_key)
REFERENCES datavault_grade_hub(grade_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_grade_user_link
ADD FOREIGN KEY (grade_key)
REFERENCES datavault_grade_hub(grade_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_grade_user_link
ADD FOREIGN KEY (user_key)
REFERENCES datavault_user_hub(user_key)
ON UPDATE CASCADE ON DELETE RESTRICT;