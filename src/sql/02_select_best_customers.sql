-- CUSTOMER WHO BOUGHT FOR MORE THAN $30 IN THE PAST 4 MONTHS
-- FROM '2014-08-01'

CREATE TABLE train_active_clients AS 
    SELECT user_id,
            SUM(price) AS total_bought

    FROM events_complete

    WHERE event_timestamp BETWEEN DATETIME('2014-08-01 00:00:00', '-4 months') AND '2014-08-01 00:00:00'
      AND event_type = 'buy_order'

    GROUP BY user_id
    HAVING total_bought >= 30
