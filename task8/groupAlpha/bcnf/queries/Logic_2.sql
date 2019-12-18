DROP TABLE IF EXISTS SUPERVISORS_INFO;
CREATE TABLE
	SUPERVISORS_INFO
AS
SELECT
	teacherNames.Fullname, teacher_volume.TASK_VOLUME
FROM
(
	SELECT
		teacherIDs.TeacherID,  userFullnames.Fullname
	FROM
	(
		SELECT
			UserID, Fullname
		FROM
			logic.users
	) as userFullnames
	CROSS JOIN
	(
		SELECT
			TeacherID, UserID
		FROM
			logic.teachers
	) as teacherIDs
	ON teacherIDs.UserID = userFullnames.UserID
) as teacherNames
CROSS JOIN
(
	SELECT
		supervisor_teachers.TeacherID, count(*) as TASK_VOLUME
	FROM
	(
		SELECT
			SupervisorID
		FROM
			logic.grades
		WHERE
			MONTH(date) = (MONTH(CURDATE())  + 12 - 1)%12 + 1
	) as supervisor_grades
		CROSS JOIN
	(
		SELECT
			TeacherID, SupervisorID /*Mojno postavit DISTINCT*/
		FROM
			logic.supervisors
	) as supervisor_teachers
	ON supervisor_grades.SupervisorID = supervisor_teachers.SupervisorID
	GROUP BY
		supervisor_teachers.TeacherID
) as teacher_volume
ON teacherNames.TeacherID = teacher_volume.TeacherID

