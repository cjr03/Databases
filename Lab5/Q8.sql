WITH blood_pressure_observations AS (
    SELECT o.phlid, o.start, ob.diastolic AS diastolic, ob.systolic AS systolic
    FROM Observation o, Observable ob
    WHERE o.observation_id = ob.observation_id AND ob.kind = 'bloodpressure'
    GROUP BY o.phlid, o.start, diastolic, systolic
    HAVING diastolic > 97 AND systolic > 196
),
heart_rate_observations AS (
    SELECT o.phlid, o.start, ob.rate AS heart_rate
    FROM Observation o, Observable ob
    WHERE o.observation_id = ob.observation_id AND ob.kind = 'heartrate'
    GROUP BY o.phlid, o.start, heart_rate
)
SELECT b.phlid, b.diastolic, b.systolic, h.heart_rate, b.start
FROM blood_pressure_observations b, heart_rate_observations h
WHERE b.phlid = h.phlid AND b.start = h.start;
