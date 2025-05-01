WITH kinds AS (
    SELECT COUNT(DISTINCT kind) AS total
    FROM Observer
), userAndKind AS (
    SELECT phlid, COUNT(DISTINCT kind) AS user_kinds
    FROM Observer
    GROUP BY phlid
)
SELECT phlid
FROM userAndKind
WHERE user_kinds = (SELECT total FROM kinds);