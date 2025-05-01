SELECT COUNT(DISTINCT m.phlid)
FROM Member m 
WHERE (m.phlid, m.iname) NOT IN (
	SELECT a.phlid, a.iname 
    FROM About a, Member m
    WHERE a.iname = m.iname AND a.phlid = m.phlid
);


