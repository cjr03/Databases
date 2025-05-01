DELIMITER //
CREATE TRIGGER Check_PHLogger_Before_Insert
BEFORE INSERT ON Thought
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM PHLogger
        WHERE phlid = NEW.phlid
    ) THEN
        SIGNAL SQLSTATE '02000'
        SET MESSAGE_TEXT = 'ERROR: PHLogger does not exist!';
    END IF;
END//
DELIMITER ;