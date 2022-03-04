CREATE TABLE test
(
    x INTEGER,
    y INTEGER
);

INSERT INTO test
SELECT x, x
FROM generate_series(1, 200000) AS f(x);

CREATE INDEX i_test ON test (x, y);
CREATE INDEX i_test2 ON test2 (x, y DESC);

/**
  Test table
 */
EXPLAIN ANALYSE
SELECT * FROM test;
EXPLAIN ANALYSE
SELECT * FROM test LIMIT 1;
EXPLAIN ANALYSE
SELECT * FROM test ORDER BY x, y DESC;
EXPLAIN ANALYSE
SELECT * FROM test ORDER BY x, y DESC LIMIT 1;
EXPLAIN ANALYSE
SELECT * FROM test ORDER BY x, y DESC LIMIT 100;

/**
  Test2 table
 */
EXPLAIN ANALYSE
SELECT * FROM test2;
EXPLAIN ANALYSE
SELECT * FROM test2 LIMIT 1;
EXPLAIN ANALYSE
SELECT * FROM test2 ORDER BY x, y DESC;
EXPLAIN ANALYSE
SELECT * FROM test2 ORDER BY x, y DESC LIMIT 1;
EXPLAIN ANALYSE
SELECT * FROM test2 ORDER BY x, y DESC LIMIT 100;
