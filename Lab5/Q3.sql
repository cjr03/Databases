SELECT model, manufacturer
FROM Observer
WHERE kind = 'smartwatch' AND observer_id IN (
	SELECT observer_id
    FROM Observable
    WHERE diastolic IN (
		SELECT MIN(diastolic)
        FROM Observable
	)
); 
