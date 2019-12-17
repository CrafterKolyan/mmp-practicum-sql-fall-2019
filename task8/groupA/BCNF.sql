DROP TABLE IF EXISTS bcnf_user_group;
DROP TABLE IF EXISTS bcnf_users;
DROP TABLE IF EXISTS bcnf_groups;

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