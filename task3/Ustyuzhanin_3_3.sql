SELECT
	basic.years, basic.opns, basic.prlngs, stonks._50perc 
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
				account_rk as acc, YEAR(renewed_dt) as years, opening_amt
			FROM
				srcdt.account_periods
		) as fst
		CROSS JOIN
		(
			SELECT
				account_rk as acc, YEAR(renewed_dt) as years, opening_amt
			FROM
				srcdt.account_periods
		) as snd
		ON fst.acc = snd.acc AND fst.years + 1 = snd.years AND snd.opening_amt > 1.5 * fst.opening_amt
    )
    GROUP BY
		years
) as stonks
ON basic.years = stonks.years
