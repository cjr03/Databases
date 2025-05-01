DROP PROCEDURE IF EXISTS AddThought; 

DELIMITER //

CREATE PROCEDURE lab6.AddThought (
   IN phlid        varchar(8),
   IN iname        VARCHAR(20),
   IN text         VARCHAR(300)
)
BEGIN
	DECLARE next_tnum INT;
    
    SELECT IFNULL(MAX(tnum), 0) + 1 INTO next_tnum
    FROM Thought t
    WHERE t.phlid = phlid;
    
    INSERT INTO Thought (phlid, tnum, text, date)
    VALUES (phlid, next_tnum, text, NOW());
    
    INSERT INTO About (phlid, tnum, iname)
    VALUES (phlid, next_tnum, iname);
END//

DELIMITER ;

call AddThought(1, "alcoholism 0", "PHLogger APP IS THE BEST!");

SELECT * FROM About a, Thought t WHERE a.phlid = 1 AND t.phlid = a.phlid AND a.tnum = t.tnum AND t.text LIKE "PHLogger%";
