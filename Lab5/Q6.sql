SELECT i.eid, (
	SELECT e.ename
    FROM Event e
    WHERE e.eid = i.eid
)
FROM Indicate i
WHERE i.eid IN (
	SELECT e.eid
    FROM Event e
    WHERE MINUTE(TIMEDIFF(start, end)) > 45
)
GROUP BY i.eid
HAVING COUNT(i.eid) > 3;
