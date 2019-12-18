SELECT
	StudentID, GroupID, FullName, AVG(Grade) as MeanGrade, COUNT(TaskID) as TaskNum
FROM
	students_info
WHERE
	abs(datediff(CURDATE(), LastDate)) <= 30
GROUP BY
	GroupID, StudentID
HAVING
	TaskNum >= 5
ORDER BY MeanGrade DESC LIMIT 5