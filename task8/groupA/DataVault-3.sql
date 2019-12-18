SELECT students.group_key - 1 AS group_key, IFNULL(count_solutions, 0) / count_tasks / count_students AS part_of_solved
FROM (
  SELECT group_key, COUNT(*) AS count_students
  FROM datavault_user_group_link AS ugl
  JOIN datavault_user_group_satellite AS ugs
  ON ugl.`user_group_key` = ugs.`user_group_key`
  WHERE tutor = 0
  GROUP BY group_key
) AS students JOIN (
  SELECT group_key, COUNT(*) AS count_tasks
  FROM datavault_task_assignment_link AS tal
  JOIN datavault_assignment_satellite AS ass
  ON tal.`assignment_key` = ass.`assignment_key`
  JOIN datavault_assignment_group_link AS agl
  ON agl.`assignment_key` = tal.`assignment_key`
  WHERE deadline < NOW()
  GROUP BY group_key 
) AS tasks
ON tasks.group_key = students.group_key
 LEFT JOIN (
  SELECT group_key, COUNT(*) AS count_solutions
  FROM datavault_task_assignment_link AS tal
  JOIN datavault_assignment_satellite AS ass
  ON tal.`assignment_key` = ass.`assignment_key`
  JOIN datavault_solution_task_link AS stl
  ON tal.`task_key` = stl.`task_key`
  JOIN datavault_assignment_group_link AS agl
  ON agl.`assignment_key` = tal.`assignment_key`
  WHERE deadline < NOW()
  GROUP BY group_key
) AS solutions
ON solutions.group_key = students.group_key

ORDER BY group_key