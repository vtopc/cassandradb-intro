-- Create a table
CREATE TABLE IF NOT EXISTS hr.employees (
    company_id uuid,
    employee_id timeuuid,
    card_number bigint, -- табельний номер
    first_name int,
    last_name int,
    photo blob,
    city text,
    hired_at timestamp,

    department_id int,

    created_at timestamp,
    updated_at timestamp,

    PRIMARY KEY (employee_id) -- Partition Key
);

CREATE TABLE IF NOT EXISTS hr.employees_by_company (
    company_id uuid,
    employee_id timeuuid,
    card_number bigint, -- табельний номер
    first_name int,
    last_name int,
    photo blob,
    city text,
    hired_at timestamp,

    department_id int,

    created_at timestamp,
    updated_at timestamp,
    PRIMARY KEY ((company_id), card_number) -- Clustering Key
)
WITH CLUSTERING ORDER BY (card_number ASC); -- ASC - сортування по замовчування
-- create index https://docs.datastax.com/en/cql-oss/3.x/cql/cql_reference/cqlCreateIndex.html


-- CREATE MATERIALIZED VIEW hr.employees_by_departments AS
-- SELECT * FROM hr.employees
-- WHERE department_id IS NOT NULL AND species IS NOT NULL
--     PRIMARY KEY (department_name, card_number)
-- WITH comment='Allow query by department instead of card_number';


CREATE TABLE IF NOT EXISTS hr.departments (
    company_id uuid,
    department_id uuid,
    department_name text,
    PRIMARY KEY (department_id))
);
