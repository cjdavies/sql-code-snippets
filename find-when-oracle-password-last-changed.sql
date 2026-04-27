SELECT name, ptime
FROM sys.user$
WHERE ptime IS NOT NULL
ORDER BY ptime DESC, name ASC;