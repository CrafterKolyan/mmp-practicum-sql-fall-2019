SELECT
  years.year_no,
  IFNULL(deposits, 0) AS deposits_openings,
  IFNULL(prolongations, 0) AS prolongations,
  IFNULL(prolongations_with_50_percent_boost, 0) AS prolongations_with_50_percent_boost
FROM (
  SELECT DISTINCT
    year_no
  FROM
    calendar
  ) AS years
  LEFT JOIN (
    SELECT
      YEAR(renewed_dt) AS year_no,
      COUNT(*) AS deposits
    FROM
      account_periods
    WHERE account_renewal_cnt = 1
    GROUP BY year_no) AS deposits
    ON years.year_no = deposits.year_no
  LEFT JOIN (
    SELECT
      YEAR(renewed_dt) AS year_no,
      COUNT(*) AS prolongations
    FROM
      account_periods
    WHERE account_renewal_cnt > 1
    GROUP BY year_no) AS prolongations
    ON years.year_no = prolongations.year_no
  LEFT JOIN (
    SELECT
      YEAR(ac2.renewed_dt) AS year_no,
      COUNT(*) AS prolongations_with_50_percent_boost
    FROM
      account_periods AS ac1
      JOIN account_periods AS ac2
        ON ac1.account_rk = ac2.account_rk
        AND ac1.account_renewal_cnt + 1 = ac2.account_renewal_cnt
    WHERE ac1.opening_amt * 3 < 2 * ac2.opening_amt
    GROUP BY year_no) AS prolongations_50
    ON years.year_no = prolongations_50.year_no
