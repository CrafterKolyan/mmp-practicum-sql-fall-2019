DROP TABLE IF EXISTS STUDENTS_INFO;
CREATE TABLE
	STUDENTS_INFO
AS
SELECT
	students_submissions.StudentID, students_submissions.GroupID, students_submissions.FullName, students_submissions.TaskID, grades_for_submissions.Grade, grades_for_submissions.LastDate
FROM

(
	SELECT
		students.StudentID, fullnames.FullName, students.GroupID, submissions.SubmissionID, submissions.TaskID
	FROM
	(
		SELECT
			*
		FROM
			logic.students
	) as students
	CROSS JOIN
	(
		SELECT
			SubmissionID, StudentID, TaskID
		FROM
			logic.submissions
	) as submissions
	CROSS JOIN
	(
		SELECT
			UserID, FullName
		FROM
        logic.users
	) as fullnames
	ON students.StudentID = submissions.StudentID AND students.UserID = fullnames.UserID
) as students_submissions
CROSS JOIN
(
	SELECT
		supervisors.SubmissionID, grades.Grade, max(grades.Date) as LastDate
	FROM
	(
		SELECT
			GradeID, SupervisorID, Grade, Date
		FROM
			logic.grades
    ) as grades
    CROSS JOIN
    (
    
		SELECT
			SupervisorID, SubmissionID
		FROM
			logic.supervisors
    ) as supervisors
    ON grades.SupervisorID = supervisors.SupervisorID
    GROUP BY supervisors.SubmissionID
) as grades_for_submissions
ON grades_for_submissions.SubmissionID = students_submissions.SubmissionID

