BEGIN;

INSERT INTO companies(name)
VALUES ('RollbackLab');

SELECT * FROM companies
WHERE name = 'RollbackLab';

ROLLBACK;

SELECT * FROM companies
WHERE name = 'RollbackLab';
-- Test whether an uncommitted INSERT can be undone