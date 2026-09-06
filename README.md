# Metallurgical Plant Database

Relational database project for a metallurgical plant.

## About the project

This university database project models key production processes of a metallurgical plant: workshops, equipment, employees, raw materials, technological operations, products, production batches, quality control, customer orders and shipments.

## Main tasks

- Subject area analysis
- ER model design
- Relational schema design
- Primary and foreign key definition
- Database creation with SQL
- Sample data population
- Analytical SQL queries

## Technologies

- SQL
- PostgreSQL
- Relational database design
- ER modeling
- IDEF1X

## Main entities

- Plant
- Workshop
- Equipment
- Employee
- Raw material
- Material
- Product
- Production operation
- Production output
- Batch
- Quality control
- Customer order
- Carrier
- Shipment

## SQL features demonstrated

- CREATE TABLE
- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- INSERT
- INNER JOIN
- LEFT JOIN
- CASE
- GROUP BY
- HAVING
- aggregate functions
- nested SELECT
- indexes

## Project structure

```text
metallurgical-plant-database/
├── schema.sql
├── data.sql
├── queries.sql
├── er-diagram.png
├── report.pdf
└── README.md
```

## Run

Create a PostgreSQL database, connect to it and execute:

```sql
\i schema.sql
\i data.sql
```

Then run analytical queries from:

```text
queries.sql
```

## Example analytical tasks

The project contains queries that:

- retrieve products, workshops and production dates
- classify production batches by quality
- calculate production volume by workshop
- include workshops with zero production using LEFT JOIN
- find the product with the maximum batch mass

## Purpose

The project demonstrates practical skills in relational database design, SQL development, data integrity constraints and analytical queries.

## Author

Ivan Kornaukhov

Business Informatics student interested in Data Engineering, SQL and database development.
