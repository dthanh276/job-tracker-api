
-- W01-03: Job Tracker SQL Reports

-- Report 1: Number of applications per company
-- Include companies with zero applications

SELECT companies.name,
       COUNT(applications.id) AS application_count
FROM companies
LEFT JOIN applications
    ON companies.id = applications.company_id
GROUP BY companies.id;


-- Report 2: Companies with at least 3 applications

SELECT companies.name,
       COUNT(applications.id) AS application_count
FROM companies
LEFT JOIN applications
    ON companies.id = applications.company_id
GROUP BY companies.id
HAVING COUNT(applications.id) >= 3;


-- Report 3: Number of applications by status

SELECT applications.status,
       COUNT(*) AS application_count
FROM applications
GROUP BY applications.status;


-- Report 4: Applications grouped by company and status

SELECT companies.name,
       applications.status,
       COUNT(applications.id) AS application_count
FROM companies
JOIN applications
    ON companies.id = applications.company_id
GROUP BY companies.id, applications.status;


-- Report 5: Companies ranked by application count
-- Include companies with zero applications

SELECT companies.name,
       COUNT(applications.id) AS application_count
FROM companies
LEFT JOIN applications
    ON companies.id = applications.company_id
GROUP BY companies.id
ORDER BY application_count DESC;


-- Report 6: Companies with no applications

SELECT companies.name,
       COUNT(applications.id) AS application_count
FROM companies
LEFT JOIN applications
    ON companies.id = applications.company_id
WHERE applications.id IS NULL
GROUP BY companies.id;


-- Report 7: Number of notes per application
-- Include applications with zero notes

SELECT applications.id,
       applications.role,
       COUNT(notes.id) AS note_count
FROM applications
LEFT JOIN notes
    ON applications.id = notes.application_id
GROUP BY applications.id;


-- Report 8: Application and note totals per company

SELECT companies.name,
       COUNT(DISTINCT applications.id) AS application_count,
       COUNT(notes.id) AS note_count
FROM companies
LEFT JOIN applications
    ON companies.id = applications.company_id
LEFT JOIN notes
    ON applications.id = notes.application_id
GROUP BY companies.id;
