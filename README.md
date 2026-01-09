# Data Warehouse and Analytics Project

## Overview

This repository contains a complete data warehousing and analytics solution, covering the full lifecycle from data ingestion to analytical reporting. The project is designed as a portfolio showcase and follows widely used industry standards in data engineering and analytics.

The focus is on building a modern data warehouse and enabling meaningful insights through well-structured data models and SQL-based analytics.

---

## Data Architecture

The project implements a Medallion Architecture consisting of three layers:

### Bronze Layer
- Stores raw data in its original form
- Data is ingested from CSV files into a SQL Server database
- Minimal transformations are applied at this stage

### Silver Layer
- Performs data cleansing, standardization, and normalization
- Resolves data quality issues and prepares data for analysis

### Gold Layer
- Contains business-ready data
- Data is modeled into a star schema optimized for reporting and analytics

---

## Project Scope

This project covers the following components:

- Data Architecture design using Bronze, Silver, and Gold layers
- ETL pipelines for extracting, transforming, and loading data
- Data modeling with fact and dimension tables
- SQL-based analytics and reporting for actionable insights

---

## Skills Demonstrated

This repository is for students aiming to demonstrate experience in:

- SQL Development
- Data Architecture
- Data Engineering
- ETL Pipeline Development
- Data Modeling
- Data Analytics

---

## Tools and Resources

All tools used in this project are:

- Datasets: CSV files used as source data (provided by Data with Baraa SQL Course Mastery)
- SQL Server Express: Database engine for hosting the data warehouse
- SQL Server Management Studio (SSMS): Interface for database management and querying
- GitHub: Version control and project collaboration
- DrawIO: Data architecture, modeling, and flow diagrams
- Notion: Detailed breakdown of project phases and tasks with documentation

---

## Project Requirements

### Building the Data Warehouse

Objective  
Develop a modern SQL Server-based data warehouse to consolidate sales data and support analytical reporting.

Specifications
- Data Sources: Two source systems (ERP and CRM) provided as CSV files
- Data Quality: Clean and validate data prior to analysis
- Integration: Combine both source systems into a unified analytical data model
- Scope: Focus on the most recent dataset only; historization is not required
- Documentation: Provide clear documentation for both technical and business users

---

### BI and Analytics (Data Analysis)

Objective  
Create SQL-based analytics that deliver insights into:

- Customer behavior
- Product performance
- Sales trends

These insights support data-driven decision-making for business stakeholders.
