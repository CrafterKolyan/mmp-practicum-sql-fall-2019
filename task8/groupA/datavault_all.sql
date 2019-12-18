-- Query #1

SELECT 
    u_s.login AS student
FROM (
	SELECT
		user_key,
		AVG(tmp_tbl.grade) AS mean_grade
	FROM (
        SELECT
            user_key,
            group_key,
            LoadDTS,
            grade
        FROM (
            SELECT
                *,
                ROW_NUMBER()
            OVER (
                PARTITION BY
                    user_key,
                    task_key
                ORDER BY
                    LoadDTS DESC
            ) AS r_number
            FROM (
                SELECT
                    u_s_l.user_key AS user_key,
                    a_grp_l.group_key AS group_key,
                    s_t_l.task_key AS task_key,
                    grd_s.LoadDTS AS LoadDTS,
                    grd_s.grade AS grade
                FROM
                    s_gr1.datavault_grade_satellite AS grd_s
                INNER JOIN
                    s_gr1.datavault_grade_solution_link grd_s_l
                ON
                    grd_s.grade_key = grd_s_l.grade_key
                INNER JOIN
                    s_gr1.datavault_user_solution_link AS u_s_l
                ON
                    grd_s_l.solution_key = u_s_l.solution_key
                INNER JOIN
                    s_gr1.datavault_solution_task_link AS s_t_l
                ON
                    grd_s_l.solution_key = s_t_l.solution_key
                INNER JOIN 
                    s_gr1.datavault_task_assignment_link AS t_a_l
                ON
                    s_t_l.task_key = t_a_l.task_key
                INNER JOIN
                    s_gr1.datavault_assignment_group_link as a_grp_l
                ON
                    t_a_l.assignment_key = a_grp_l.assignment_key
            ) AS tmp_tmp_tbl
        ) AS tmp_tbl
        WHERE
            r_number = 1
    ) AS tmp_tbl
    WHERE
        tmp_tbl.LoadDTS >= DATE_ADD(NOW(), INTERVAL -30 DAY)
    GROUP BY
        tmp_tbl.group_key,
        tmp_tbl.user_key
) AS user_key_to_login
INNER JOIN
    s_gr1.datavault_user_satellite AS u_s
ON
    user_key_to_login.user_key = u_s.user_key
ORDER BY
    mean_grade DESC,
	u_s.login
LIMIT
	5
;


-- -----------------------------------------------------------------------------

-- Query #2

SELECT
	u_s.login AS login
FROM
	s_gr1.datavault_user_satellite AS u_s
LEFT JOIN
	s_gr1.datavault_grade_user_link AS grd_u_l
INNER JOIN
    s_gr1.datavault_grade_satellite AS grd_s
ON
    grd_u_l.grade_key = grd_s.grade_key AND
    STR_TO_DATE(
		CONCAT(
			YEAR(DATE_ADD(NOW(), INTERVAL -1 MONTH)), '-',
            MONTH(DATE_ADD(NOW(), INTERVAL -1 MONTH)), '-',
            1
		),
		'%Y-%m-%d'
	) <= grd_s.LoadDTS AND
    grd_s.LoadDTS < DATE_ADD(
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
ON
	u_s.user_key = grd_u_l.user_key
GROUP BY
	u_s.login
ORDER BY
	SUM(grd_u_l.user_key IS NOT NULL) DESC
LIMIT
	5
;

-- -----------------------------------------------------------------------------


-- Query #3

SELECT
	students.group_key - 1 AS group_key,
    IFNULL(count_solutions, 0) / count_tasks / count_students AS part_of_solved
FROM (
	SELECT
		group_key,
		COUNT(*) AS count_students
	FROM
		datavault_user_group_link AS ugl
	JOIN
		datavault_user_group_satellite AS ugs
	ON
		ugl.user_group_key = ugs.user_group_key
	WHERE
		tutor = 0
	GROUP BY
		group_key
) AS students
JOIN (
	SELECT
		group_key,
		COUNT(*) AS count_tasks
	FROM
		datavault_task_assignment_link AS tal
	JOIN
		datavault_assignment_satellite AS ass
	ON
		tal.assignment_key = ass.assignment_key
	JOIN
		datavault_assignment_group_link AS agl
	ON
		agl.assignment_key = tal.assignment_key
	WHERE
		deadline < NOW()
	GROUP BY
		group_key 
) AS tasks
ON
	tasks.group_key = students.group_key
LEFT JOIN (
	SELECT
		group_key,
		COUNT(*) AS count_solutions
	FROM
		datavault_task_assignment_link AS tal
	JOIN
		datavault_assignment_satellite AS ass
	ON
		tal.assignment_key = ass.assignment_key
	JOIN
		datavault_solution_task_link AS stl
	ON
		tal.task_key = stl.task_key
	JOIN
		datavault_assignment_group_link AS agl
	ON
		agl.assignment_key = tal.assignment_key
	WHERE
		deadline < NOW()
	GROUP BY
		group_key
) AS solutions
ON
	solutions.group_key = students.group_key
ORDER BY
	group_key
;


-- -----------------------------------------------------------------------------

-- Query #4

SELECT
	u_grp_l.group_key - 1 AS group_key,
	COUNT(*) AS students_amount
FROM
	s_gr1.datavault_user_group_link AS u_grp_l
INNER JOIN
    s_gr1.datavault_user_group_satellite AS u_grp_s
ON 
    u_grp_l.user_group_key = u_grp_s.user_group_key
WHERE
	u_grp_s.tutor = 0
GROUP BY
	u_grp_l.group_key
ORDER BY
	students_amount DESC,
    u_grp_l.group_key
;
