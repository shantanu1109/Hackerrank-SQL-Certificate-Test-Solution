WITH QuarterVolumes AS (
    SELECT
        C.Algorithm,
        Quarter(Dt) AS Quarter,
        SUM(Volume) AS V
    FROM
        coins C
        INNER JOIN transactions t ON t.coin_code = C.code
    WHERE
        Year(Dt) = 2020
    GROUP BY
        C.Algorithm, Quarter(Dt)
)

SELECT
    Q1.Algorithm,
    Q1.V AS Q1_v,
    Q2.V AS Q2_v,
    Q3.V AS Q3_v,
    Q4.V AS Q4_v
FROM
    QuarterVolumes Q1
    LEFT JOIN QuarterVolumes Q2 ON Q1.Algorithm = Q2.Algorithm AND Q2.Quarter = 2
    LEFT JOIN QuarterVolumes Q3 ON Q1.Algorithm = Q3.Algorithm AND Q3.Quarter = 3
    LEFT JOIN QuarterVolumes Q4 ON Q1.Algorithm = Q4.Algorithm AND Q4.Quarter = 4
WHERE
    Q1.Quarter = 1
ORDER BY
    Q1.Algorithm ASC;
