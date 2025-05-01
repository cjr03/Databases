SELECT name, (
	SELECT email 
    FROM User 
    WHERE User.phlid = Phlogger.phlid
) AS email
FROM Phlogger
WHERE phlid IN (
    SELECT phlid FROM About 
    WHERE iname IN (
        SELECT iname FROM Member 
        WHERE phlid = About.phlid
        AND iname IN (
            SELECT iname FROM Interest 
            WHERE topic = 'exercise'
        )
    )
);
