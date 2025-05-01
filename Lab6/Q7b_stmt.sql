DELIMITER //
CREATE TRIGGER AutoJoinInterest
AFTER INSERT ON PHLogger
FOR EACH ROW
BEGIN
    DECLARE random_interest VARCHAR(20);
    
    SELECT iname INTO random_interest 
    FROM Interest 
    ORDER BY RAND() 
    LIMIT 1;
    
    INSERT INTO Member (phlid, iname)
    VALUES (NEW.phlid, random_interest);
    
    INSERT INTO Thought (phlid, tnum, text, date)
    VALUES (NEW.phlid, 1, 'Hello!', NOW());
    
    INSERT INTO About (phlid, tnum, iname)
    VALUES (NEW.phlid, 1, random_interest);
END//
DELIMITER ;