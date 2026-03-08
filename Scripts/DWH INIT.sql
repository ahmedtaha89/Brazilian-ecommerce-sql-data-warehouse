
/* =========================
   DROP FACTS FIRST
   ========================= */

IF OBJECT_ID(N'gold.fact_order_review', N'U') IS NOT NULL
    DROP TABLE gold.fact_order_review;
GO

IF OBJECT_ID(N'gold.fact_order_payment', N'U') IS NOT NULL
    DROP TABLE gold.fact_order_payment;
GO

IF OBJECT_ID(N'gold.fact_order_item', N'U') IS NOT NULL
    DROP TABLE gold.fact_order_item;
GO

/* =========================
   DROP DIMENSIONS
   ========================= */

IF OBJECT_ID(N'gold.dim_payment_type', N'U') IS NOT NULL
    DROP TABLE gold.dim_payment_type;
GO

IF OBJECT_ID(N'gold.dim_order_status', N'U') IS NOT NULL
    DROP TABLE gold.dim_order_status;
GO

IF OBJECT_ID(N'gold.dim_product', N'U') IS NOT NULL
    DROP TABLE gold.dim_product;
GO

IF OBJECT_ID(N'gold.dim_seller', N'U') IS NOT NULL
    DROP TABLE gold.dim_seller;
GO

IF OBJECT_ID(N'gold.dim_customer', N'U') IS NOT NULL
    DROP TABLE gold.dim_customer;
GO

IF OBJECT_ID(N'gold.dim_date', N'U') IS NOT NULL
    DROP TABLE gold.dim_date;
GO

/* =========================
   CREATE DIMENSION TABLES
   ========================= */

CREATE TABLE gold.dim_date
(
    date_key         INT            NOT NULL PRIMARY KEY,
    full_date        DATE           NOT NULL UNIQUE,
    day_of_month     TINYINT        NOT NULL,
    month_number     TINYINT        NOT NULL,
    month_name       VARCHAR(20)    NOT NULL,
    quarter_number   TINYINT        NOT NULL,
    year_number      SMALLINT       NOT NULL,
    iso_week_number  TINYINT        NOT NULL,
    is_weekend       BIT            NOT NULL
);
GO

CREATE TABLE gold.dim_customer
(
    customer_key              INT IDENTITY(1,1) PRIMARY KEY,
    customer_id               NVARCHAR(50)  NOT NULL UNIQUE,
    customer_unique_id        NVARCHAR(50)  NULL,
    customer_zip_code_prefix  INT           NULL,
    customer_city             NVARCHAR(100) NULL,
    customer_state            CHAR(2)       NULL
);
GO

CREATE TABLE gold.dim_seller
(
    seller_key               INT IDENTITY(1,1) PRIMARY KEY,
    seller_id                NVARCHAR(50)  NOT NULL UNIQUE,
    seller_zip_code_prefix   INT           NULL,
    seller_city              NVARCHAR(100) NULL,
    seller_state             CHAR(2)       NULL
);
GO

CREATE TABLE gold.dim_product
(
    product_key                    INT IDENTITY(1,1) PRIMARY KEY,
    product_id                     NVARCHAR(50)  NOT NULL UNIQUE,
    product_category_name          NVARCHAR(100) NULL,
    product_category_name_english  NVARCHAR(100) NULL,
    product_name_lenght            INT           NULL,
    product_description_lenght     INT           NULL,
    product_photos_qty             INT           NULL,
    product_weight_g               INT           NULL,
    product_length_cm              INT           NULL,
    product_height_cm              INT           NULL,
    product_width_cm               INT           NULL
);
GO

CREATE TABLE gold.dim_order_status
(
    order_status_key   INT IDENTITY(1,1) PRIMARY KEY,
    order_status       NVARCHAR(30) NOT NULL UNIQUE
);
GO

CREATE TABLE gold.dim_payment_type
(
    payment_type_key   INT IDENTITY(1,1) PRIMARY KEY,
    payment_type       NVARCHAR(30) NOT NULL UNIQUE
);
GO

/* =========================
   CREATE FACT TABLES
   ========================= */

CREATE TABLE gold.fact_order_item
(
    order_item_fact_key            BIGINT IDENTITY(1,1) PRIMARY KEY,
    order_id                       NVARCHAR(50)  NOT NULL,
    order_item_id                  INT           NOT NULL,
    customer_key                   INT           NULL,
    seller_key                     INT           NULL,
    product_key                    INT           NULL,
    order_status_key               INT           NULL,
    purchase_date_key              INT           NULL,
    approved_date_key              INT           NULL,
    shipping_limit_date_key        INT           NULL,
    delivered_carrier_date_key     INT           NULL,
    delivered_customer_date_key    INT           NULL,
    estimated_delivery_date_key    INT           NULL,
    price_amount                   DECIMAL(12,2) NULL,
    freight_amount                 DECIMAL(12,2) NULL,
    item_count                     INT           NOT NULL DEFAULT 1
);
GO

CREATE TABLE gold.fact_order_payment
(
    order_payment_fact_key   BIGINT IDENTITY(1,1) PRIMARY KEY,
    order_id                 NVARCHAR(50)  NOT NULL,
    payment_sequential       INT           NOT NULL,
    customer_key             INT           NULL,
    payment_type_key         INT           NULL,
    purchase_date_key        INT           NULL,
    payment_installments     INT           NULL,
    payment_value            DECIMAL(12,2) NULL
);
GO

CREATE TABLE gold.fact_order_review
(
    order_review_fact_key       BIGINT IDENTITY(1,1) PRIMARY KEY,
    review_id                   NVARCHAR(60)  NOT NULL,
    order_id                    NVARCHAR(60)  NOT NULL,
    customer_key                INT           NULL,
    review_creation_date_key    INT           NULL,
    review_answer_date_key      INT           NULL,
    review_score                INT           NULL,
    has_comment                 BIT           NOT NULL
);
GO

/* =========================
   FOREIGN KEYS
   ========================= */

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_customer
        FOREIGN KEY (customer_key) REFERENCES gold.dim_customer(customer_key);
GO

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_seller
        FOREIGN KEY (seller_key) REFERENCES gold.dim_seller(seller_key);
GO

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_product
        FOREIGN KEY (product_key) REFERENCES gold.dim_product(product_key);
GO

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_status
        FOREIGN KEY (order_status_key) REFERENCES gold.dim_order_status(order_status_key);
GO

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_purchase_date
        FOREIGN KEY (purchase_date_key) REFERENCES gold.dim_date(date_key);
GO

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_approved_date
        FOREIGN KEY (approved_date_key) REFERENCES gold.dim_date(date_key);
GO

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_ship_date
        FOREIGN KEY (shipping_limit_date_key) REFERENCES gold.dim_date(date_key);
GO

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_carrier_date
        FOREIGN KEY (delivered_carrier_date_key) REFERENCES gold.dim_date(date_key);
GO

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_customer_date
        FOREIGN KEY (delivered_customer_date_key) REFERENCES gold.dim_date(date_key);
GO

ALTER TABLE gold.fact_order_item
    ADD CONSTRAINT FK_fact_order_item_est_date
        FOREIGN KEY (estimated_delivery_date_key) REFERENCES gold.dim_date(date_key);
GO

ALTER TABLE gold.fact_order_payment
    ADD CONSTRAINT FK_fact_order_payment_customer
        FOREIGN KEY (customer_key) REFERENCES gold.dim_customer(customer_key);
GO

ALTER TABLE gold.fact_order_payment
    ADD CONSTRAINT FK_fact_order_payment_type
        FOREIGN KEY (payment_type_key) REFERENCES gold.dim_payment_type(payment_type_key);
GO

ALTER TABLE gold.fact_order_payment
    ADD CONSTRAINT FK_fact_order_payment_purchase_dt
        FOREIGN KEY (purchase_date_key) REFERENCES gold.dim_date(date_key);
GO

ALTER TABLE gold.fact_order_review
    ADD CONSTRAINT FK_fact_order_review_customer
        FOREIGN KEY (customer_key) REFERENCES gold.dim_customer(customer_key);
GO

ALTER TABLE gold.fact_order_review
    ADD CONSTRAINT FK_fact_order_review_creation_date
        FOREIGN KEY (review_creation_date_key) REFERENCES gold.dim_date(date_key);
GO

ALTER TABLE gold.fact_order_review
    ADD CONSTRAINT FK_fact_order_review_answer_date
        FOREIGN KEY (review_answer_date_key) REFERENCES gold.dim_date(date_key);
GO

/* =========================
   INDEXES
   ========================= */

CREATE INDEX IX_fact_order_item_order_id
    ON gold.fact_order_item(order_id);
GO

CREATE INDEX IX_fact_order_payment_order_id
    ON gold.fact_order_payment(order_id);
GO

CREATE INDEX IX_fact_order_review_order_id
    ON gold.fact_order_review(order_id);
GO