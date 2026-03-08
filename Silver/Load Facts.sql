/* =========================================================
   FACT: gold.fact_order_item
   ========================================================= */
INSERT INTO gold.fact_order_item
(
    order_id,
    order_item_id,
    customer_key,
    seller_key,
    product_key,
    order_status_key,
    purchase_date_key,
    approved_date_key,
    shipping_limit_date_key,
    delivered_carrier_date_key,
    delivered_customer_date_key,
    estimated_delivery_date_key,
    price_amount,
    freight_amount
)
SELECT
    oi.order_id,
    oi.order_item_id,
    dc.customer_key,
    ds.seller_key,
    dp.product_key,
    dos.order_status_key,
    dd_purchase.date_key,
    dd_approved.date_key,
    dd_ship_limit.date_key,
    dd_delivered_carrier.date_key,
    dd_delivered_customer.date_key,
    dd_estimated.date_key,
    oi.price        AS price_amount,
    oi.freight_value AS freight_amount
FROM silver.orders_items oi
INNER JOIN silver.orders o
    ON o.order_id = oi.order_id
INNER JOIN silver.customers c
    ON c.customer_id = o.customer_id
INNER JOIN gold.dim_customer dc
    ON dc.customer_id = c.customer_id
INNER JOIN gold.dim_seller ds
    ON ds.seller_id = oi.seller_id
INNER JOIN gold.dim_product dp
    ON dp.product_id = oi.product_id
INNER JOIN gold.dim_order_status dos
    ON dos.order_status = o.order_status
LEFT JOIN gold.dim_date dd_purchase
    ON dd_purchase.full_date = CAST(o.order_purchase_timestamp AS date)
LEFT JOIN gold.dim_date dd_approved
    ON dd_approved.full_date = CAST(o.order_approved_at AS date)
LEFT JOIN gold.dim_date dd_ship_limit
    ON dd_ship_limit.full_date = CAST(o.order_approved_at AS date)
LEFT JOIN gold.dim_date dd_delivered_carrier
    ON dd_delivered_carrier.full_date = CAST(o.order_delivered_carrier_date AS date)
LEFT JOIN gold.dim_date dd_delivered_customer
    ON dd_delivered_customer.full_date = CAST(o.order_delivered_customer_date AS date)
LEFT JOIN gold.dim_date dd_estimated
    ON dd_estimated.full_date = CAST(o.order_estimated_delivery_date AS date)
WHERE NOT EXISTS
(
    SELECT 1
    FROM gold.fact_order_item f
    WHERE f.order_id = oi.order_id
      AND f.order_item_id = oi.order_item_id
);
GO


/* =========================================================
   FACT: gold.fact_order_payment
   ========================================================= */
INSERT INTO gold.fact_order_payment
(
    order_id,
    payment_sequential,
    customer_key,
    payment_type_key,
    purchase_date_key,
    payment_installments,
    payment_value
)
SELECT
    op.order_id,
    op.payment_sequential,
    dc.customer_key,
    dpt.payment_type_key,
    dd_purchase.date_key,
    op.payment_installments,
    op.payment_value
FROM silver.order_payments op
INNER JOIN silver.orders o
    ON o.order_id = op.order_id
INNER JOIN silver.customers c
    ON c.customer_id = o.customer_id
INNER JOIN gold.dim_customer dc
    ON dc.customer_id = c.customer_id
INNER JOIN gold.dim_payment_type dpt
    ON dpt.payment_type = op.o_payment_type
LEFT JOIN gold.dim_date dd_purchase
    ON dd_purchase.full_date = CAST(o.order_purchase_timestamp AS date)
WHERE NOT EXISTS
(
    SELECT 1
    FROM gold.fact_order_payment f
    WHERE f.order_id = op.order_id
      AND f.payment_sequential = op.payment_sequential
);
GO


/* =========================================================
   FACT: gold.fact_order_review
   ========================================================= */
INSERT INTO gold.fact_order_review
(
    review_id,
    order_id,
    customer_key,
    review_creation_date_key,
    review_answer_date_key,
    review_score,
    has_comment
)
SELECT
    r.review_id,
    r.order_id,
    dc.customer_key,
    dd_creation.date_key,
    dd_answer.date_key,
    r.review_score,
    CASE
        WHEN NULLIF(LTRIM(RTRIM(COALESCE(r.review_comment_title, ''))), '') IS NOT NULL
          OR NULLIF(LTRIM(RTRIM(COALESCE(r.review_comment_message, ''))), '') IS NOT NULL
        THEN 1
        ELSE 0
    END AS has_comment
FROM silver.order_reviews r
INNER JOIN silver.orders o
    ON o.order_id = r.order_id
INNER JOIN silver.customers c
    ON c.customer_id = o.customer_id
INNER JOIN gold.dim_customer dc
    ON dc.customer_id = c.customer_id
LEFT JOIN gold.dim_date dd_creation
    ON dd_creation.full_date = CAST(r.review_creation_date AS date)
LEFT JOIN gold.dim_date dd_answer
    ON dd_answer.full_date = CAST(r.review_answer_timestamp AS date)
WHERE NOT EXISTS
(
    SELECT 1
    FROM gold.fact_order_review f
    WHERE f.review_id = r.review_id
      AND f.order_id = r.order_id
);
GO