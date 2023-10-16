-- Create a table
CREATE TABLE IF NOT EXISTS hr.departments (
  company_id uuid,
  department_id uuid,
  department_name text,
  PRIMARY KEY ((company_id), department_id) -- Partition Key and Clustering Key
);

CREATE INDEX idx_department_name ON hr.departments (department_name);

CREATE MATERIALIZED VIEW hr.departments_by_name AS
SELECT * FROM hr.departments
WHERE department_name IS NOT NULL
PRIMARY KEY ((company_id), department_name)
WITH comment='Allow query by department name instead of id';

CREATE TABLE IF NOT EXISTS hr.departments_by_name (
  company_id uuid,
  department_id uuid,
  department_name text,
  PRIMARY KEY ((company_id), department_name)
)
WITH CLUSTERING ORDER BY (department_name ASC); -- ASC - сортування по замовчування

CREATE TABLE IF NOT EXISTS hr.employees (
    company_id uuid,
    employee_id timeuuid,
    card_number bigint, -- табельний номер
    first_name text,
    last_name text,
    photo blob,
    home_address text,
    hired_at timestamp,

    department_id uuid,

    created_at timestamp,
    updated_at timestamp,

    PRIMARY KEY ((company_id), employee_id)
);

CREATE TABLE IF NOT EXISTS hr.employees_by_name (
    company_id uuid,
    employee_id timeuuid,
    card_number bigint, -- табельний номер
    first_name text,
    last_name text,
    name text,

    PRIMARY KEY ((company_id), name) -- Clustering Key
)

-- create index https://docs.datastax.com/en/cql-oss/3.x/cql/cql_reference/cqlCreateIndex.html
