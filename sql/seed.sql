
-- W02-03: Job Tracker Seed Data

BEGIN;

-- 1. Insert 4 companies

INSERT INTO companies (name)
VALUES
    ('Google'),
    ('Amazon'),
    ('Microsoft'),
    ('Netflix');


-- 2. Insert 6 applications

INSERT INTO applications (company_id, role, status)
SELECT c.id, data.role, data.status
FROM (
    VALUES
        ('Google', 'Backend Engineer', 'applied'),
        ('Google', 'DevOps Engineer', 'interview'),
        ('Amazon', 'Cloud Engineer', 'rejected'),
        ('Amazon', 'SRE', 'applied'),
        ('Microsoft', 'Software Engineer', 'interview'),
        ('Microsoft', 'Platform Engineer', 'applied')
) AS data(company_name, role, status)
JOIN companies c
    ON c.name = data.company_name;


-- 3. Insert 4 notes

INSERT INTO notes (application_id, content)
SELECT a.id, data.content
FROM (
    VALUES
        ('Google', 'Backend Engineer', 'Application submitted'),
        ('Google', 'Backend Engineer', 'Waiting for response'),
        ('Google', 'DevOps Engineer', 'Interview scheduled'),
        ('Amazon', 'Cloud Engineer', 'Application rejected')
) AS data(company_name, role, content)
JOIN companies c
    ON c.name = data.company_name
JOIN applications a
    ON a.company_id = c.id
    AND a.role = data.role;

COMMIT;
