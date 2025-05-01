WITH pa AS (
    SELECT ob.phlid, AVG(o.rate) AS avg_heart_rate
    FROM Observable o
    JOIN Observer ob ON o.observer_id = ob.observer_id
    WHERE o.kind = 'heartrate'
    GROUP BY ob.phlid
), sa AS (
    SELECT ob.phlid, ob.kind, ob.manufacturer, ob.model, ob.software_version, AVG(o.rate) AS series_avg_heart_rate
    FROM Observable o
    JOIN Observer ob ON o.observer_id = ob.observer_id
    WHERE o.kind = 'heartrate'
    GROUP BY ob.phlid, ob.kind, ob.manufacturer, ob.model, ob.software_version
)
SELECT sa.phlid, ph.name AS phlogger_name, sa.kind, sa.manufacturer, sa.model, sa.software_version, sa.series_avg_heart_rate, pa.avg_heart_rate AS overall_avg_heart_rate
FROM sa
JOIN pa ON sa.phlid = pa.phlid
JOIN PHLogger ph ON sa.phlid = ph.phlid
WHERE sa.series_avg_heart_rate < 0.8 * pa.avg_heart_rate
ORDER BY sa.phlid, sa.kind, sa.manufacturer, sa.model, sa.software_version;