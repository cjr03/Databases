SELECT P.phlid, MAX(e.start)
FROM Phlogger P, Event e, Member m,Interest I,Thought T
where e.phlid = P.phlid
and m.phlid = P.phlid
and m.iname = I.iname
AND I.topic = "alcoholism"
AND T.phlid = P.phlid
AND T.text LIKE "%wasted%"
GROUP BY P.phlid
ORDER BY P.phlid;




