-- Create a table
CREATE TABLE IF NOT EXISTS hr.employees (
    employee_id timeuuid,
    card_number bigint, -- табельний номер
    first_name int,
    last_name int,
    photo blob,
    hired_at timestamp,

    department_id int,
    department_name text,

    created_at timestamp,
    updated_at timestamp,

    PRIMARY KEY (card_number)) -- Partition Key
);

CREATE TABLE IF NOT EXISTS hr.employees_by_departments (
    employee_id timeuuid,
    card_number bigint, -- табельний номер
    first_name int,
    last_name int,
    photo blob,
    hired_at timestamp,
    department_id int,
    department_name text,

    created_at timestamp,
    updated_at timestamp,
    PRIMARY KEY ((department_name), card_number) -- Clustering Key
)
WITH CLUSTERING ORDER BY (card_number ASC); -- ASC - сортування по замовчування

-- CREATE MATERIALIZED VIEW hr.employees_by_departments AS
-- SELECT * FROM hr.employees
-- WHERE department_id IS NOT NULL AND species IS NOT NULL
--     PRIMARY KEY (department_name, card_number)
-- WITH comment='Allow query by department instead of card_number';

CREATE TABLE IF NOT EXISTS hr.departments (
    department_id uuid,
    department_name text,
    PRIMARY KEY (department_id))
);
