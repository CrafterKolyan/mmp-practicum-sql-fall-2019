INSERT INTO data_vault.Users
SELECT UserId, current_timestamp() as LoadDateTimeStamp,
'data.Users' as RecordSource FROM data.Users;

INSERT INTO data_vault.Groups
SELECT GroupId, current_timestamp() as LoadDateTimeStamp,
'data.Groups' as RecordSource FROM data.Groups;

INSERT INTO data_vault.Students
SELECT StudentId, current_timestamp() as LoadDateTimeStamp,
'data.Students' as RecordSource FROM data.Students;

INSERT INTO data_vault.Teachers
SELECT TeacherId, current_timestamp() as LoadDateTimeStamp,
'data.Teachers' as RecordSource FROM data.Teachers;

INSERT INTO data_vault.Submissions
SELECT SubmissionId, current_timestamp() as LoadDateTimeStamp,
'data.Submissions' as RecordSource FROM data.Submissions;

INSERT INTO data_vault.Assignments
SELECT AssignmentId, current_timestamp() as LoadDateTimeStamp,
'data.Assignments' as RecordSource FROM data.Assignments;

INSERT INTO data_vault.Tasks
SELECT TaskId, current_timestamp() as LoadDateTimeStamp,
'data.Tasks' as RecordSource FROM data.Tasks;

INSERT INTO data_vault.Grades
SELECT GradeId, current_timestamp() as LoadDateTimeStamp,
'data.Grades' as RecordSource FROM data.Grades;

INSERT INTO data_vault.SupervisorsComments
SELECT CommentId, current_timestamp() as LoadDateTimeStamp,
'data.SupervisorsComments' as RecordSource FROM data.SupervisorsComments;

INSERT INTO data_vault.StudentsComments
SELECT CommentId, current_timestamp() as LoadDateTimeStamp,
'data.StudentsComments' as RecordSource FROM data.StudentsComments;

INSERT INTO data_vault.Supervisors
SELECT SupervisorId, current_timestamp() as LoadDateTimeStamp,
'data.Supervisors' as RecordSource FROM data.Supervisors;

INSERT INTO data_vault.Users_Students
select UserId, StudentId, current_timestamp() as LoadDateTimeStamp,
       'data.Students' from data.Students;
       
INSERT INTO data_vault.Students_Groups
select StudentId, GroupId, current_timestamp() as LoadDateTimeStamp,
       'data.Students' from data.Students;
       
INSERT INTO data_vault.Users_Groups
select CreatorId, GroupId, current_timestamp() as LoadDateTimeStamp,
       'data.Groups' from data.Groups;
       
INSERT INTO data_vault.Users_Teachers
select UserId, TeacherId, current_timestamp() as LoadDateTimeStamp,
       'data.Teachers' from data.Teachers;
	
INSERT INTO data_vault.Teachers_Groups
select GroupId, TeacherId, current_timestamp() as LoadDateTimeStamp,
       'data.Teachers' from data.Teachers;
       
INSERT INTO data_vault.Groups_Assignments
select GroupId, AssignmentId, current_timestamp() as LoadDateTimeStamp,
       'data.Assignments' from data.Assignments;
       
INSERT INTO data_vault.Assignments_Tasks
select AssignmentId, TaskId, current_timestamp() as LoadDateTimeStamp,
       'data.Tasks' from data.Tasks;
       
INSERT INTO data_vault.Tasks_Submissions
select SubmissionId, TaskId, current_timestamp() as LoadDateTimeStamp,
       'data.Submissions' from data.Submissions;
       
INSERT INTO data_vault.Teachers_Supervisors
select TeacherId, SupervisorId, current_timestamp() as LoadDateTimeStamp,
       'data.Supervisors' from data.Supervisors;
       
INSERT INTO data_vault.Submissions_Supervisors
select SubmissionId, SupervisorId, current_timestamp() as LoadDateTimeStamp,
       'data.Supervisors' from data.Supervisors;
       
INSERT INTO data_vault.Students_Submissions
select StudentId, SubmissionId, current_timestamp() as LoadDateTimeStamp,
       'data.Submissions' from data.Submissions;
       
INSERT INTO data_vault.Supervisors_SupervisorsComments
select SupervisorId, CommentId, current_timestamp() as LoadDateTimeStamp,
       'data.SupervisorsComments' from data.SupervisorsComments;
       
INSERT INTO data_vault.Submissions_StudentsComments
select SubmissionId, CommentId, current_timestamp() as LoadDateTimeStamp,
       'data.StudentsComments' from data.StudentsComments;
       
INSERT INTO data_vault.Supervisors_Grades
select SupervisorId, GradeId, current_timestamp() as LoadDateTimeStamp,
       'data.Grades' from data.Grades;

INSERT INTO data_vault.sat_Users
SELECT current_timestamp() as LoadDateTimeStamp, UserId,
'data.Users' as RecordSource, FullName, UserStatus, `e-mail` FROM data.Users;

INSERT INTO data_vault.sat_Groups
SELECT current_timestamp() as LoadDateTimeStamp, GroupId,
'data.Groups' as RecordSource, GroupName FROM data.Groups;

INSERT INTO data_vault.sat_Assignments
SELECT current_timestamp() as LoadDateTimeStamp, AssignmentId,
'data.Assignments' as RecordSource, Description, DueDate FROM data.Assignments;

INSERT INTO data_vault.sat_Submissions
SELECT current_timestamp() as LoadDateTimeStamp, SubmissionId,
'data.Submissions' as RecordSource, `Date`, Content FROM data.Submissions;

INSERT INTO data_vault.sat_Tasks
SELECT current_timestamp() as LoadDateTimeStamp, TaskId,
'data.Tasks' as RecordSource, Description FROM data.Tasks;

INSERT INTO data_vault.sat_Grades
SELECT current_timestamp() as LoadDateTimeStamp, GradeId,
'data.Grades' as RecordSource, Grade, `Date` FROM data.Grades;

INSERT INTO data_vault.sat_StudentsComments
SELECT current_timestamp() as LoadDateTimeStamp, CommentId,
'data.StudentsComments' as RecordSource, `Comment`, `Date` FROM data.StudentsComments;

INSERT INTO data_vault.sat_SupervisorsComments
SELECT current_timestamp() as LoadDateTimeStamp, CommentId,
'data.SupervisorsComments' as RecordSource, `Comment`, `Date` FROM data.SupervisorsComments;