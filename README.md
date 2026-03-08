# Brazilian E-Commerce SQL Data Warehouse

An end-to-end **SQL Data Warehouse** project built on top of the **Olist Brazilian E-Commerce Dataset**, using a layered **Bronze / Silver / Gold** architecture to transform raw e-commerce data into analytics-ready dimensional models.

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
- Visual documentation through schema and mapping screenshots

---

## Architecture

The warehouse follows a **medallion architecture**:

### Bronze Layer
Stores raw ingested data with minimal transformation.

### Silver Layer
Stores cleaned, standardized, and transformation-ready data.

### Gold Layer
Stores curated **dimension** and **fact** tables optimized for business analysis and reporting.

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

The warehouse schema is modeled using a **star-schema style dimensional design** to support analytical reporting and KPI tracking.

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

## Repository Structure

```bash
Brazilian-ecommerce-sql-data-warehouse/
│
├── Bronze/                # Raw-layer mappings
├── Data Sources/          # Source files
├── Gold/                  # Gold-layer mappings
├── Screens/               # Dataset image + ETL mapping screenshots
├── Scripts/               # DB initialization, DWH setup, audit, testing
├── Silver/                # Silver-layer mappings + fact loading SQL
├── Workflows/             # Workflow XML files
└── Schema.png             # Warehouse schema diagram
