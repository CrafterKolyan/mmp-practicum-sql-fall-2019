SELECT
	basic.years, IFNULL(basic.opns, 0), IFNULL(basic.prlngs, 0), IFNULL(stonks._50perc, 0)
FROM
(
	SELECT
		YEAR(renewed_dt) as years, SUM(account_renewal_cnt = 1) as opns, SUM(account_renewal_cnt > 1) as prlngs
	FROM
		srcdt.account_periods
	GROUP BY
		years
) as basic
LEFT JOIN
(
	SELECT
		fst.years as years, COUNT(*) as _50perc
	FROM
    (
		(
			SELECT
				account_rk as acc, YEAR(renewed_dt) as years, opening_amt, account_renewal_cnt
			FROM
				srcdt.account_periods
		) as fst
		CROSS JOIN
		(
			SELECT
				account_rk as acc, YEAR(renewed_dt) as years, opening_amt, account_renewal_cnt
			FROM
				srcdt.account_periods
		) as snd
		ON fst.acc = snd.acc AND fst.account_renewal_cnt + 1 = snd.account_renewal_cnt AND snd.opening_amt > 1.5 * fst.opening_amt
    )
    GROUP BY
		years
) as stonks
ON basic.years = stonks.years
