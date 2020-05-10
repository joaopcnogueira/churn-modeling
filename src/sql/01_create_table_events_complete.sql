CREATE TABLE events_complete AS 
    SELECT *
    FROM events AS t1
    LEFT JOIN products AS t2
    ON t1.product_id = t2.product_id
    