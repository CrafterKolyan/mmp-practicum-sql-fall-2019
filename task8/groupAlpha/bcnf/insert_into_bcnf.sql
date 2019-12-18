INSERT INTO logic.Users
SELECT * FROM data.Users;

INSERT INTO logic.Groups
SELECT * FROM data.Groups;

INSERT INTO logic.Students
SELECT * FROM data.Students;

INSERT INTO logic.Teachers
SELECT * FROM data.Teachers;

INSERT INTO logic.Assignments
SELECT * FROM data.Assignments;

INSERT INTO logic.Tasks
SELECT * FROM data.Tasks;

INSERT INTO logic.Submissions
SELECT * FROM data.Submissions;

INSERT INTO logic.Supervisors
SELECT * FROM data.Supervisors;

INSERT INTO logic.Grades
SELECT * FROM data.Grades;

INSERT INTO logic.StudentsComments
SELECT * FROM data.StudentsComments;

INSERT INTO logic.SupervisorsComments
SELECT * FROM data.SupervisorsComments;