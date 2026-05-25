SELECT class
FROM class
WHERE name=(
SELECT name
FROM score
ORDER BY score DESC
LIMIT 1 OFFSET 1
);