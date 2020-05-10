CREATE TABLE abt AS 
    SELECT pre_abt.user_id,
            features.nb_products_seen,
            features.nb_distinct_product,
            features.nb_distinct_cat_0,
            features.nb_distinct_cat_1,
            features.nb_distinct_cat_2,
            features.amount_bought,
            features.nb_product_bought,
            features.active_time,
            pre_abt.target

    FROM pre_abt
    LEFT JOIN (
        -- Features based on past data
        SELECT user_id,
                COUNT(product_id) AS nb_products_seen,
                COUNT(DISTINCT product_id) AS nb_distinct_product,
                COUNT(DISTINCT category_id_0) AS nb_distinct_cat_0,
                COUNT(DISTINCT category_id_1) AS nb_distinct_cat_1,
                COUNT(DISTINCT category_id_2) AS nb_distinct_cat_2,
                SUM(CASE WHEN event_type = 'buy_order' THEN price ELSE 0 END) AS amount_bought,
                SUM(CASE WHEN event_type = 'buy_order' THEN 1 ELSE 0 END) AS nb_product_bought,
                CAST(JULIANDAY('2014-08-01') - JULIANDAY(MIN(event_timestamp)) AS INTEGER) AS active_time
        FROM events_complete
        WHERE event_timestamp < '2014-08-01 00:00:00'
        GROUP BY user_id
    ) AS features 

    ON pre_abt.user_id = features.user_id
