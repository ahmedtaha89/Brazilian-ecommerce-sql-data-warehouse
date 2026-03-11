# Brazilian E-Commerce SQL Data Warehouse

An end-to-end **SQL Data Warehouse** project built on top of the **Olist Brazilian E-Commerce Dataset**, using a layered **Bronze / Silver / Gold** architecture to transform raw e-commerce data into analytics-ready dimensional models and dashboard-ready reporting tables.

<p align="center">
  <img src="Screens/Olist%20Brazilian%20E-commerce%20Dataset.jpg" alt="Olist Brazilian E-Commerce Dataset" width="900"/>
</p>

## Overview

This project demonstrates how to design and build a complete **e-commerce data warehouse** using SQL-based data modeling, ETL workflows, and dimensional modeling techniques.

The solution covers:

- Raw data ingestion from multiple source files
- Layered transformation using **Bronze**, **Silver**, and **Gold**
- Creation of analytics-ready **dimension** and **fact** tables
- ETL workflow orchestration
- Audit logging for ETL monitoring
- Testing and validation scripts
- Dashboard reporting pages for business analysis
- Visual documentation through schema, mapping, and dashboard screenshots

---

## Architecture

The warehouse follows a **medallion architecture**:

### Bronze Layer
Stores raw ingested data with minimal transformation.

### Silver Layer
Stores cleaned, standardized, and transformation-ready data.

### Gold Layer
Stores curated **dimension** and **fact** tables optimized for business analysis, reporting, and dashboarding.

---

## Dataset

This project is based on the **Olist Brazilian E-Commerce Dataset** and includes source entities such as:

- customers
- geolocation
- orders
- order items
- order payments
- order reviews
- products
- sellers
- product category translations

---

## Data Warehouse Schema

<p align="center">
  <img src="Schema.png" alt="Data Warehouse Schema" width="1000"/>
</p>

The warehouse schema is modeled using a **star-schema style dimensional design** to support analytical reporting, KPI tracking, and dashboard development.

---

## Gold Layer Data Model

### Dimension Tables
- `gold.dim_date`
- `gold.dim_customer`
- `gold.dim_seller`
- `gold.dim_product`
- `gold.dim_order_status`
- `gold.dim_payment_type`

### Fact Tables
- `gold.fact_order_item`
- `gold.fact_order_payment`
- `gold.fact_order_review`

These tables support analytics such as:

- sales and revenue analysis
- customer behavior analysis
- seller performance tracking
- payment method insights
- delivery and order status reporting
- product and category analysis
- review score monitoring

---

## Dashboard Pages

The project includes multiple dashboard pages built on top of the **Gold Layer** to deliver business insights and support reporting.

### 1. Overview Page
Provides a high-level summary of overall business performance, including:
- total sales
- total orders
- total customers
- average review score
- revenue trend over time

<p align="center">
  <img src="Screens/overview-page.png" alt="Overview Dashboard Page" width="900"/>
</p>

---

### 2. Sales Analysis Page
Focuses on revenue and order performance across time and categories, including:
- monthly sales trends
- yearly sales trends
- top-selling products
- revenue by category
- order volume analysis

<p align="center">
  <img src="Screens/sales-analysis-page.png" alt="Sales Analysis Dashboard Page" width="900"/>
</p>

---

### 3. Customer Insights Page
Analyzes customer activity and behavior, including:
- customer distribution
- purchasing patterns
- repeat vs one-time customers
- customer contribution to revenue

<p align="center">
  <img src="Screens/customer-insights-page.png" alt="Customer Insights Dashboard Page" width="900"/>
</p>

---

### 4. Seller Performance Page
Highlights marketplace seller performance, including:
- top sellers by revenue
- seller order volume
- seller comparisons
- seller contribution analysis

<p align="center">
  <img src="Screens/seller-performance-page.png" alt="Seller Performance Dashboard Page" width="900"/>
</p>

---

### 5. Payments & Reviews Page
Shows transaction and customer satisfaction insights, including:
- payment type distribution
- payment value analysis
- review score breakdown
- customer satisfaction trends

<p align="center">
  <img src="Screens/payments-reviews-page.png" alt="Payments and Reviews Dashboard Page" width="900"/>
</p>

---

## ETL Auditing and Testing

To improve reliability and maintainability, the project includes:

- ETL audit logging scripts
- data quality checks
- testing and validation scripts
- workflow execution support files

This helps monitor pipeline execution, validate outputs, and maintain trust in the warehouse data.

---

## Repository Structure

```bash
Brazilian-ecommerce-sql-data-warehouse/
│
├── Bronze/                # Raw-layer mappings
├── Data Sources/          # Source files
├── Gold/                  # Gold-layer mappings
├── Screens/               # Dataset, ETL mappings, and dashboard screenshots
├── Scripts/               # DB initialization, DWH setup, audit, testing
├── Silver/                # Silver-layer mappings + fact loading SQL
├── Workflows/             # Workflow XML files
└── Schema.png             # Warehouse schema diagram
