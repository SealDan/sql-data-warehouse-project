# Gold Layer Data Catalog

## Overview
The Gold Layer contains business-ready data designed for analytics and reporting. It is organized into **dimension tables** and **fact tables** that capture business entities and measurable metrics.

---

## 1. gold.dim_customers
**Purpose:** Contains customer information enriched with demographic and geographic attributes.

### Columns

| Column Name     | Data Type    | Description                                                                                   |
|-----------------|--------------|-----------------------------------------------------------------------------------------------|
| customer_key    | INT          | Surrogate key uniquely identifying each customer record.                                       |
| customer_id     | INT          | System-generated unique identifier for each customer.                                         |
| customer_number | NVARCHAR(50) | Alphanumeric customer reference used for tracking and identification.                         |
| first_name      | NVARCHAR(50) | Customer’s given name.                                                                        |
| last_name       | NVARCHAR(50) | Customer’s surname or family name.                                                            |
| country         | NVARCHAR(50) | Customer’s country of residence.                                                              |
| marital_status  | NVARCHAR(50) | Customer’s marital status (e.g., Married, Single).                                            |
| gender          | NVARCHAR(50) | Customer’s gender (e.g., Male, Female, Unknown).                                                  |
| birthdate       | DATE         | Customer’s date of birth (YYYY-MM-DD).                                                        |
| create_date     | DATE         | Date when the customer record was created.                                                    |

---

## 2. gold.dim_products
**Purpose:** Stores descriptive information and attributes related to each product.

### Columns

| Column Name           | Data Type    | Description                                                                                 |
|-----------------------|--------------|---------------------------------------------------------------------------------------------|
| product_key           | INT          | Surrogate key uniquely identifying each product.                                            |
| product_id            | INT          | Unique internal identifier assigned to each product.                                        |
| product_number        | NVARCHAR(50) | Alphanumeric product code used for identification and categorization.                       |
| product_name          | NVARCHAR(50) | Descriptive product name, including model or size details.                                  |
| category_id           | NVARCHAR(50) | Identifier linking the product to a broader category.                                       |
| category              | NVARCHAR(50) | High-level product classification (e.g., Bikes, Components).                               |
| subcategory           | NVARCHAR(50) | More granular classification within the category.                                           |
| maintenance_required  | NVARCHAR(50) | Indicates whether the product requires maintenance (Yes/No).                                |
| cost                  | INT          | Base cost of the product in whole currency units.                                           |
| product_line          | NVARCHAR(50) | Product line or series (e.g., Road, Mountain).                                              |
| start_date            | DATE         | Date when the product became available for sale or use.                                     |

---

## 3. gold.fact_sales
**Purpose:** Records transactional sales data used for analytical and reporting purposes.

### Columns

| Column Name   | Data Type    | Description                                                                                   |
|---------------|--------------|-----------------------------------------------------------------------------------------------|
| order_number  | NVARCHAR(50) | Unique alphanumeric identifier for each sales order.                                          |
| product_key   | INT          | Surrogate key referring to the product dimension.                                             |
| customer_key  | INT          | Surrogate key referring to the customer dimension.                                            |
| order_date    | DATE         | Date the order was placed.                                                                    |
| shipping_date | DATE         | Date the order was shipped.                                                                   |
| due_date      | DATE         | Due date for the order payment.                                                               |
| sales_amount  | INT          | Total revenue for the sales line item.                                                        |
| quantity      | INT          | Number of product units sold.                                                                 |
| price         | INT          | Unit price of the product at the time of sale.                                                |

---
