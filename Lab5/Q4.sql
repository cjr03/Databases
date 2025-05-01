SELECT * FROM PHlogger WHERE phlid IN
    (SELECT phlid
    FROM Member,Interest I
    WHERE I.topic LIKE '%exercise%' AND I.iname = Member.iname
INTERSECT    
    SELECT E.phlid
    FROM Observation O, Indicate I,PHLG_obs PO, Event E
    WHERE O.observation_id = I.observation_id AND
    I.eid = E.eid AND E.ename = 'camping' and PO.observation_id = O.observation_id AND
    PO.text LIKE '%jet skiing%');
