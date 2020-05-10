-- CREATE THE TARGET VARIABLE (CHURN) FOR THE BEST CUSTOMERS.
-- THE TARGET VARIABLE IS DEFINED AS IF THE CLIENT HAS NOT MADE
-- ANY PURCHASE IN THE NEXT 4 MONTHS FROM '2014-08-01', 
-- THEN ITS ASSIGN THE VALUE OF 1 (CHURN) OTHERWISE 0 (NOT CHURN)

CREATE TABLE pre_abt AS 
    SELECT t1.user_id,
            CASE WHEN t2.user_id IS NULL THEN 1 ELSE 0 END AS target

    FROM train_active_clients AS t1

    LEFT JOIN (
        SELECT DISTINCT user_id
        FROM events_complete
        WHERE event_timestamp BETWEEN '2014-08-01 00:00:00' AND DATETIME('2014-08-01 00:00:00', '+4 months') 
          AND event_type = 'buy_order'
    ) AS t2 
    ON t1.user_id = t2.user_id
