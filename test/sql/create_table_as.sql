CREATE TABLE r (a int);
INSERT INTO r VALUES (1), (2), (3);

CREATE TABLE c (a int) USING columnstore;
INSERT INTO c VALUES (1), (2), (3);

CREATE TABLE t AS SELECT * FROM r;
SELECT * FROM t;
DROP TABLE t;

CREATE TABLE t AS SELECT * FROM c;
SELECT * FROM t;
DROP TABLE t;

CREATE TABLE t USING columnstore AS SELECT * FROM r;
SELECT * FROM t;
DROP TABLE t;

CREATE TABLE t USING columnstore AS SELECT * FROM c;
SELECT * FROM t;
DROP TABLE t;

CREATE TABLE t USING columnstore AS SELECT * FROM r WITH NO DATA;
SELECT * FROM t;
DROP TABLE t;

CREATE TABLE t USING columnstore AS TABLE r;
SELECT * FROM t;
DROP TABLE t;

CREATE TABLE t USING columnstore AS VALUES (123, 'abc');
SELECT * FROM t;
DROP TABLE t;

DROP TABLE r, c;
