SELECT tasks.group_id, IFNULL(count_solutions, 0) / count_tasks / count_students AS part_of_solved
FROM (
SELECT COUNT(*) AS count_tasks, group_id
FROM bcnf_assignment
JOIN bcnf_tasks
ON bcnf_assignment.`assignment_id` = bcnf_tasks.`assignment_id`
WHERE bcnf_assignment.`deadline` < NOW()
GROUP BY group_id
) AS tasks
JOIN (
SELECT COUNT(*) AS count_students, group_id
FROM bcnf_user_group
WHERE tutor = 0
GROUP BY group_id
) AS students
ON students.group_id = tasks.group_id
LEFT JOIN
(
SELECT COUNT(*) AS count_solutions, group_id
FROM bcnf_assignment
JOIN bcnf_tasks
ON bcnf_assignment.`assignment_id` = bcnf_tasks.`assignment_id`
JOIN bcnf_solutions
ON bcnf_tasks.`task_id` = bcnf_solutions.`task_id`
WHERE bcnf_assignment.`deadline` < NOW()
GROUP BY group_id ) AS solutions 
ON solutions.group_id = tasks.group_id