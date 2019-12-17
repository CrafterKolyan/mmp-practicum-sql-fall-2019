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
    discipline VARCHAR(120),
    TEXT VARCHAR(1000),
    deadline DATETIME NOT NULL,
    PRIMARY KEY(assignment_key, LoadDTS)
);

CREATE TABLE IF NOT EXISTS datavault_task_satellite
(
    task_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    TEXT VARCHAR(1000),
    PRIMARY KEY(task_key, LoadDTS)
);

CREATE TABLE IF NOT EXISTS datavault_grade_satellite
(
    grade_key INT NOT NULL AUTO_INCREMENT,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    COMMENT VARCHAR(1000) NOT NULL,
    grade INT NOT NULL,
    PRIMARY KEY(grade_key, LoadDTS)
);

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

CREATE TABLE IF NOT EXISTS datavault_assignment_group_link
(
    group_assignment_key INT NOT NULL AUTO_INCREMENT,
    group_key INT NOT NULL,
    assignment_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(group_assignment_key)
);

CREATE TABLE IF NOT EXISTS datavault_user_assignment_link
(
    user_assignment_key INT NOT NULL AUTO_INCREMENT,
    user_key INT NOT NULL,
    assignment_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(user_assignment_key)
);

CREATE TABLE IF NOT EXISTS datavault_task_assignment_link
(
    assignment_task_key INT NOT NULL AUTO_INCREMENT,
    assignment_key INT NOT NULL,
    task_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(assignment_task_key)
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

CREATE TABLE IF NOT EXISTS datavault_solution_assignment_link
(
    solution_task_key INT NOT NULL AUTO_INCREMENT,
    solution_key INT NOT NULL,
    task_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(solution_task_key)
);

CREATE TABLE IF NOT EXISTS datavault_user_solution_link
(
    user_solution_key INT NOT NULL AUTO_INCREMENT,
    user_key INT NOT NULL,
    solution_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(user_solution_key)
);

CREATE TABLE IF NOT EXISTS datavault_grade_solution_link
(
    grade_solution_key INT NOT NULL AUTO_INCREMENT,
    grade_key INT NOT NULL,
    solution_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(grade_solution_key)
);

CREATE TABLE IF NOT EXISTS datavault_grade_user_link
(
    grade_solution_key INT NOT NULL AUTO_INCREMENT,
    grade_key INT NOT NULL,
    user_key INT NOT NULL,
    LoadDTS TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResSrc VARCHAR(40),
    PRIMARY KEY(grade_solution_key)
);

INSERT INTO datavault_user_hub
SELECT user_key, LoadDTS, ResSrc FROM datavault_user_satellite;

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
ADD FOREIGN KEY (task_key)
REFERENCES datavault_assignment_hub(task_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_task_assignment_link
ADD FOREIGN KEY (assignment_key)
REFERENCES datavault_task_hub(assignment_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_solution_satellite
ADD FOREIGN KEY (solution_key)
REFERENCES datavault_solution_hub(solution_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_solution_assignment_link
ADD FOREIGN KEY (assignment_key)
REFERENCES datavault_task_hub(assignment_key)
ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE datavault_solution_assignment_link
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