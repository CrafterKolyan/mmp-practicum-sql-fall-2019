-- Query #1

SELECT
    tmp_tbl.student AS student
FROM (
    SELECT
        *
    FROM (
        SELECT
            *,
            ROW_NUMBER()
        OVER (
            PARTITION BY
                student,
                task_id
            ORDER BY
                grade_datetime DESC
        ) AS r_number
        FROM
            bcnf_grades
    ) AS tmp_tbl
    WHERE
        r_number = 1
) AS tmp_tbl
JOIN
    bcnf_tasks AS t
ON
    tmp_tbl.task_id = t.task_id
JOIN
    bcnf_assignment AS a
ON
    t.assignment_id = a.assignment_id
WHERE
    tmp_tbl.grade_datetime >= DATE_ADD(NOW(), INTERVAL -30 DAY)
GROUP BY
    a.group_id,
    tmp_tbl.student
ORDER BY
    AVG(tmp_tbl.grade) DESC,
    tmp_tbl.student
LIMIT
    5
;


-- -----------------------------------------------------------------------------

-- Query #2

SELECT
    u.login AS login
FROM
    s_gr1.bcnf_users AS u
LEFT JOIN
    s_gr1.bcnf_grades AS g
ON
    u.login = g.grader AND
    STR_TO_DATE(
        CONCAT(
            YEAR(DATE_ADD(NOW(), INTERVAL -1 MONTH)), '-',
            MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH)), '-',
            1
        ),
        '%Y-%m-%d'
    ) <= g.grade_datetime AND
    g.grade_datetime < DATE_ADD(
        STR_TO_DATE(
            CONCAT(
                YEAR(DATE_ADD(NOW(), INTERVAL -1 MONTH)), '-',
                MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH)), '-',
                1
            ),
            '%Y-%m-%d'
        ),
        INTERVAL 1 MONTH
    )
GROUP BY
    u.login
ORDER BY
    SUM(g.grader IS NOT NULL) DESC
LIMIT
    5
;


-- -----------------------------------------------------------------------------

-- Query #3

SELECT
    tasks.group_id AS group_id,
    IFNULL(count_solutions, 0) / count_tasks / count_students AS part_of_solved
FROM (
    SELECT
        COUNT(*) AS count_tasks,
        group_id
    FROM
        bcnf_assignment
    JOIN
        bcnf_tasks
    ON
        bcnf_assignment.assignment_id = bcnf_tasks.assignment_id
    WHERE
        bcnf_assignment.deadline < NOW()
    GROUP BY
        group_id
) AS tasks
JOIN (
    SELECT
        COUNT(*) AS count_students,
        group_id
    FROM
        bcnf_user_group
    WHERE
        tutor = 0
    GROUP BY
        group_id
) AS students
ON
    students.group_id = tasks.group_id
LEFT JOIN (
    SELECT
        COUNT(*) AS count_solutions,
        group_id
    FROM
        bcnf_assignment
    JOIN
        bcnf_tasks
    ON
        bcnf_assignment.assignment_id = bcnf_tasks.assignment_id
    JOIN
        bcnf_solutions
    ON
        bcnf_tasks.task_id = bcnf_solutions.task_id
    WHERE
        bcnf_assignment.deadline < NOW()
    GROUP BY
        group_id
) AS solutions
ON
    solutions.group_id = tasks.group_id
;


-- -----------------------------------------------------------------------------

-- Query #4

SELECT
    group_id,
    COUNT(*) AS students_amount
FROM
    s_gr1.bcnf_user_group AS ug
WHERE
    ug.tutor = 0
GROUP BY
    ug.group_id
ORDER BY
    students_amount DESC,
    group_id
;

