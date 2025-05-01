ALTER TABLE About
DROP FOREIGN KEY About_ibfk_1;

ALTER TABLE Thought
DROP PRIMARY KEY;

ALTER TABLE Thought
ADD COLUMN thought_id INT AUTO_INCREMENT PRIMARY KEY FIRST;

ALTER TABLE Thought
MODIFY phlid VARCHAR(8) NULL;

ALTER TABLE About
ADD COLUMN thought_id INT,
ADD CONSTRAINT About_ibfk_1
  FOREIGN KEY (thought_id) REFERENCES Thought(thought_id)
  ON DELETE CASCADE;
  
UPDATE About a
JOIN Thought t ON a.phlid = t.phlid AND a.tnum = t.tnum
SET a.thought_id = t.thought_id;

ALTER TABLE Thought
ADD UNIQUE KEY unique_thought (phlid, tnum);