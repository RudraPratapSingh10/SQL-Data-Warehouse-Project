# 📘 Data Warehouse Naming Standards

This document defines naming conventions for tables, columns, and stored procedures across Bronze, Silver, and Gold layers.

---

## 🚀 General Guidelines

- Use **snake_case**
- Use **English only**
- Avoid **SQL reserved keywords**
- Keep names **clear and consistent**

---

## 🗂️ Table Naming

### 🟤 Bronze Layer (Raw Data)

- Raw data from source systems
- Keep original table names
- Add source prefix

**Format:**  
`<source_system>_<table_name>`

**Example:**  
`crm_customer_info`  
`erp_orders`

---

### ⚪ Silver Layer (Cleaned Data)

- Cleaned and structured data
- Same naming as Bronze (no rename)

**Format:**  
`<source_system>_<table_name>`

---

### 🟡 Gold Layer (Business Layer)

- Business-friendly names

**Format:**  
`<category>_<entity>`

**Examples:**  
`dim_customers`  
`fact_sales`  
`report_monthly_revenue`

---

### 📖 Prefix Guide

| Prefix    | Meaning            | Example              |
|----------|-------------------|----------------------|
| dim_     | Dimension table   | dim_products         |
| fact_    | Fact table        | fact_orders          |
| report_  | Reporting table   | report_sales_summary |

---

## 🧱 Column Naming

### 🔑 Surrogate Keys

**Format:**  
`<entity>_key`

**Example:**  
`customer_key`

---

### ⚙️ Technical Columns

**Format:**  
`dwh_<name>`

**Examples:**  
`dwh_load_date`  
`dwh_updated_at`

---

## ⚡ Stored Procedures

**Format:**  
`load_<layer>`

**Examples:**  
`load_bronze`  
`load_silver`  
`load_gold`

---

## ✅ Why It Matters

- Better readability  
- Easy maintenance  
- Consistent structure  
