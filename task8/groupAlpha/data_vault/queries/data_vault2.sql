DROP TABLE IF EXISTS SUPERVISORS_INFO;
CREATE TABLE SUPERVISORS_INFO
AS
SELECT teacherNames.Fullname, teacher_volume.TASK_VOLUME
FROM
(
SELECT teacherIDs.TeacherID,  userFullnames.Fullname
FROM
	(
		SELECT
			UserID, Fullname
		FROM
			data_vault.sat_Users
	) as userFullnames
	CROSS JOIN
	(
		SELECT
			TeacherID, UserID
		FROM
			data_vault.Users_Teachers
	) as teacherIDs
	ON teacherIDs.UserID = userFullnames.UserID
) as teacherNames
CROSS JOIN
(
	SELECT
		supervisor_teachers.TeacherID, count(*) as TASK_VOLUME
	FROM
	(
		(
		SELECT
			SupervisorID, GradeID
		FROM
			data_vault.Supervisors_Grades
		) as super_grades
		CROSS JOIN
        (
		SELECT
			GradeID, Date
		FROM
			data_vault.sat_grades
		WHERE
			MONTH(Date) = (MONTH(CURDATE())  + 12 - 1)%12 + 1
        ) as grades_date
        ON super_grades.GradeID = grades_date.GradeID

	) as supervisor_grades
		CROSS JOIN
	(
		SELECT
			TeacherID, SupervisorID /*Mojno postavit DISTINCT*/
		FROM
			data_vault.Teachers_Supervisors
	) as supervisor_teachers
	ON supervisor_grades.SupervisorID = supervisor_teachers.SupervisorID
	GROUP BY
		supervisor_teachers.TeacherID
) as teacher_volume
ON teacherNames.TeacherID = teacher_volume.TeacherID
ORDER BY TASK_VOLUME DESC LIMIT 5;
SELECT * FROM SUPERVISORS_INFO
