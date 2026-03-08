select * from [silver].[olist_order_payments]

select * from silver.customers
select * from gold.dim_customer
-----------------------------
select * from silver.products
select * from gold.dim_product
-----------------------------
select distinct order_status from silver.orders
select  * from gold.dim_order_status
order by 1 


select DISTINCT payment_type from silver.order_payments
select *  from silver.order_payments
select *  from gold.dim_payment_type
-----------------------------------
select *  from silver.sellers
select *  from gold.dim_seller
----------------------------------
select distinct order_purchase_timestamp from silver.orders
select * from gold.dim_date
---------------
select * from gold.fact_order_item
select * from gold.fact_order_payment
select * from gold.fact_order_review
select min(order_purchase_timestamp) from [silver].Orders
select * from [silver].order_reviews

select * from [silver].olist_customers
select * from [silver].Products
select * from [silver].olist_order_payments

DECLARE @StartDate DATE = '2016-01-01'
DECLARE @EndDate DATE = '2025-12-31'

WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO Dim_Date
    SELECT
        CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),
        @StartDate,
        DAY(@StartDate),
        DATENAME(WEEKDAY, @StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATEPART(DAYOFYEAR, @StartDate),
        DATEPART(WEEK, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATEPART(QUARTER, @StartDate),
        YEAR(@StartDate),

        CASE WHEN DATENAME(WEEKDAY, @StartDate) IN ('Saturday','Sunday') THEN 1 ELSE 0 END,
        CASE WHEN DAY(@StartDate) = 1 THEN 1 ELSE 0 END,
        CASE WHEN EOMONTH(@StartDate) = @StartDate THEN 1 ELSE 0 END,
        CASE WHEN DATEPART(DAY,@StartDate)=1 AND DATEPART(MONTH,@StartDate) IN (1,4,7,10) THEN 1 ELSE 0 END,
        CASE WHEN EOMONTH(@StartDate)=@StartDate AND DATEPART(MONTH,@StartDate) IN (3,6,9,12) THEN 1 ELSE 0 END,
        CASE WHEN MONTH(@StartDate)=1 AND DAY(@StartDate)=1 THEN 1 ELSE 0 END,
        CASE WHEN MONTH(@StartDate)=12 AND DAY(@StartDate)=31 THEN 1 ELSE 0 END

    SET @StartDate = DATEADD(DAY,1,@StartDate)

END
