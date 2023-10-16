-- Insert
INSERT INTO hr.departments (company_id, department_id, department_name)
VALUES (00000000-0000-0000-0000-000000000001, uuid(), 'Відділ кадрів');

INSERT INTO hr.departments (company_id, department_id, department_name)
VALUES (00000000-0000-0000-0000-000000000001, uuid(), 'Служба безпеки');

-- Batch

BEGIN BATCH

INSERT INTO hr.departments (company_id, department_id, department_name)
VALUES (00000000-0000-0000-0000-000000000001, 00000000-0000-0000-0000-000000000002, 'Відділ кадрів');

INSERT INTO hr.departments_by_name (company_id, department_id, department_name)
VALUES (00000000-0000-0000-0000-000000000001, 00000000-0000-0000-0000-000000000002, 'Відділ кадрів');

APPLY BATCH;

-- Select
SELECT department_id FROM hr.departments_by_name
WHERE
        company_id = 00000000-0000-0000-0000-000000000001
  AND
        department_name = 'Відділ кадрів';

-- TTL
INSERT INTO hr.salary (employee_id, amount, period_begin_date, period_end_date) VALUES (123, 100500, '2023-10-01', '2023-10-14') USING TTL 157680000;
