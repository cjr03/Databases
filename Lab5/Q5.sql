WITH m3ball AS (
    SELECT i.eid, COUNT(i.observation_id) AS ball_events
    FROM Indicate i
    WHERE i.eid IN (
        SELECT e.eid
        FROM Event e
        WHERE e.ename LIKE '%ball%'
    )
    GROUP BY i.eid
    HAVING COUNT(i.observation_id) >= 3
)
SELECT e.ename AS event_name, 
	(
	SELECT m3ball.ball_events
	FROM m3ball
	WHERE m3ball.eid = e.eid
    ) AS number_of_observations
FROM Event e
WHERE e.eid IN (
    SELECT m3ball.eid
    FROM m3ball
); 
