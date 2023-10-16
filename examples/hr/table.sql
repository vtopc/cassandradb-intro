-- Create a table
CREATE TABLE IF NOT EXISTS hr.departments (
  company_id uuid,
  department_id uuid,
  department_name text,
  PRIMARY KEY ((company_id, department_id)) -- Composite Partition Key
);

CREATE INDEX idx_department_name ON hr.departments (department_name);

CREATE CUSTOM INDEX ON hr.employees (name) USING 'org.apache.cassandra.index.sasi.SASIIndex'
WITH OPTIONS = {'case_sensitive': 'false', 'mode': 'CONTAINS'};

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
    department_id uuid,
    department_name text static,
    employee_id timeuuid,
    card_number bigint, -- табельний номер
    name text,
    photo blob,
    salary decimal,
    hired_at date,
    vacation duration,
    tags set<text>, -- кортеж
    duties map<text, text>, -- карта

    PRIMARY KEY ((department_id), employee_id)
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
