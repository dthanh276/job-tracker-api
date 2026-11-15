-- 1. Create 100,000 sample records in a temporary table

CREATE TEMP TABLE test_products AS
SELECT
    id,
    'Product-' || id AS name
FROM generate_series(1, 100000) AS g(id);

-- 2. Update PostgreSQL statistics
ANALYZE test_products;

-- 3. Verify the number of records
SELECT COUNT(*) FROM test_products;

-- 4. Measure performance WITHOUT an index
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, name
FROM test_products
WHERE name = 'Product-50000';

-- 5. Create a B-tree index on the searched column
CREATE INDEX idx_test_products_name
ON test_products(name);

-- 6. Measure performance WITH the index
EXPLAIN (ANALYZE, BUFFERS)
SELECT id, name
FROM test_products
WHERE name = 'Product-50000';


-- OBSERVATIONS
--
-- Without index:
-- Scan type: Seq Scan
-- Execution time:2.594 ms
-- Buffer usage: local hit=640
--
-- With index:
-- Scan type: Index Scan
-- Execution time: 0.022 ms
-- Buffer usage: local hit=1 read=3
--
-- CONCLUSION
-- Indexes require additional storage and maintenance
-- during INSERT, UPDATE and DELETE operations.
--
-- These are single-run measurements; results may vary.
