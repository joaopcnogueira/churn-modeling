SELECT COUNT(*) FROM events

SELECT event_type,
        COUNT(event_type) AS n
FROM events
GROUP BY event_type
ORDER BY 2 DESC
