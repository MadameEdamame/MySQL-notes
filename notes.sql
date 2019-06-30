
/*====================== General =====================*/
SHOW DATABASES; /* show all databases */

SELECT DATABASE(); /* show current database */

DROP DATABASE databsename; /* delete database */

use databsename; /* switch to this database and work on it */


/*====================== Create Table =====================*/
CREATE TABLE cats (
	name VARCHAR(20), 
	age INT
);

CREATE TABLE cats (
	cat_id INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(20) NOT NULL DEFAULT 'noname', 
	age INT NOT NULL DEFAULT 99, 
	PRIMARY KEY (cat_id)
); /* use the first category, cat_id, as the unique identifier */

OR

CREATE TABLE cats (
	cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(20) NOT NULL DEFAULT 'noname', 
	age INT NOT NULL DEFAULT 99
); 

DESC cats; /* describe cats table */

DROP TABLE cats; /* delete table */

SHOW TABLES; /* shows all tables in this database */


/*====================== Insert Data into Table =====================*/
INSERT INTO cats(name, age) 
VALUES('Jerry', 10); /* insert jerry and 10 into name and age of cats */

INSERT INTO cats(name, age) 
VALUES('Jerry', 10)
, ('mimi', 2); /* insert multiple */

SELECT * FROM cats; /* shows data in cats */


/*====================== READ =======================*/
SELECT * FROM cats; /* read ALL(*) columns from cats table */

SELECT name FROM cats; 

SELECT name, age FROM cats;

SELECT * FROM cats WHERE age=4;

SELECT cat_id, age FROM cats WHERE cat_id=age;

SELECT cat_id AS id, name AS 'kitty breed' FROM cats; /* aliases, use in joint table, to distinguish */


/*======================= UPDATE =======================*/
UPDATE cats SET breed='Shorthair' WHERE breed='Tabby'; /* update that certain thing, set it to blah */


/*======================= DELETE ========================*/
DELETE FROM cats WHERE name='Egg';

DELETE FROM cats; /* DELETE ALL!!! NOT DROPPING, Still has a table */


/*=================== Run a SQL File ====================*/
source first_file.sql; /* type everything in thie sql file instead in terminal */

source test/notes.sql


/*==================== String Functions =======================*/
/* CONCAT */
SELECT
	CONCAT(author_fname, ' ', author_lname) AS 'Full Name'
FROM books; /* put them together */

SELECT author_fname AS first, author_lname AS last, 
	CONCAT(author_fname, ', ', author_lname) AS full
FROM books;

SELECT
	CONCAT_WS(' - ', title, author_fname, author_lname)
FROM books; /* insert a - between each item without repeatedly typing */


/* SUBSTRING */
SELECT SUBSTRING ('HELLO WORLD', 7); /* gives W, MySQL starts with 1!! */

SELECT SUBSTRING ('HELLO WORLD', 1, 4); /* HELL */

SELECT SUBSTRING ('HELLO WORLD', -3); /* RLD, last 3 */

SHORT: SUBSTR(...);


/* REPLACE */
SELECT REPLACE('HELLO WORLD', 'HELL', '#**$'); /* CASE-SENSITIVE! */

/* REVERSE */
SELECT REVERSE('HELLO WORLD'); /* DLROW OLLEH */

/* CHAR_LENGTH */
SELECT CHAR_LENGTH('HELLO WORLD'); /* gives the length of the string, 11 */

SELECT author_lname, CHAR_LENGTH(author_lname) AS 'length' FROM books;

/* UPPER AND LOWER */
SELECT UPPER('Hello World'); /* caps */

SELECT LOWER('Hello World'); /* lower */


/* ====================== Distinct ===================*/
SELECT DISTINCT author_lname FROM books; /* gives distinct author names, get rid of duplicates */

SELECT DISTINCT author_lname, author_fname FROM books;


/* ===================== Order By ==================== */
SELECT author_lname FROM books ORDER BY author_lname; /* Asending by default, remember to include space between order and by */

SELECT author_lname FROM books ORDER BY author_lname DESC; /* z to a, ASC & DESC, works with NUMBERS too */

SELECT title, author_fname, author_lname FROM books ORDER BY 2; /* order by 2nd item, author_fname */

SELECT author_fname, author_lname FROM books ORDER BY author_lname, author_fname; /* kepp the first sort, lname, and sort more if theres conflict */


/* ======================= Limit ====================== */
SELECT title FROM books LIMIT 3; /* gives the first 3 book */

SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 5;

SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 2, 5; /* (first is 0) start from 2 (the 3rd book), and go for 5 times */

/* ====================== Like ======================= */
SELECT title, author_fname FROM books WHERE author_fname LIKE '%da%';
 
SELECT title, author_fname FROM books WHERE author_fname LIKE 'da%';

SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '__';
 
(235)234-0987 LIKE '(___)___-____'

SELECT title FROM books WHERE title LIKE '%\%%'




/* ======================= Count ======================= */
SELECT COUNT(*) FROM books;

SELECT COUNT(DISTINCT author_fname) FROM books;

SELECT COUNT(*) FROM books WHERE title LIKE '%the%';


/* ======================= Group By ======================= */
SELECT title, author_lname FROM books GROUP BY author_lname;

SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname; /* counts how many books each author has written */

SELECT released_year, COUNT(*) FROM books GROUP BY released_year;


/* ======================= Min & Max ========================= */
SELECT Min(released_year) FROM books; /* or max */

SELECT * FROM books WHERE pages = (SELECT Min(pages) FROM books); /* gives the book with minimum pages, TOO SLOW */

SELECT * FROM books ORDER BY pages ASC LIMIT 1; /* same as above, FASTER */

SELECT author_fname, author_lname, Min(released_year) FROM books GROUP BY author_lname, author_fname;


/* ====================== Sum ===================== */
SELECT Sum(pages) FROM books;

SELECT author_fname, author_lname, Sum(pages) FROM books GROUP BY author_lname, author_fname;


/* ====================== Avg ======================= */
SELECT Avg(released_year) FROM books;






/* ================================ DATA TYPES!! ===================================== */
DECIMAL(5, 2) /* total num of digits, digits after decimal point, max of 999.99 */

FLOAT(12.88) /* precision of 7 digits */

DOUBLE(12.88) /* precision of 15 digits */


/* ================================ Dates & Times =============================== */
DATE /* YYYY-MM-DD format, no time */

TIME /* HH:MM:SS, no date */

DATETIME /* YYYY-MM-DD HH:MM:SS */

CURDATE() /* current date */

CURTIME()

NOW()

INSERT INTO people (name, birthdate, birthtime, birthdt) VALUES('Microwave', CURDATE(), CURTIME(), NOW());


/* ============================== FORMATTING DATES ============================= */
DAY() /* 22 (if was 1996-11-22) */
DAYNAME() /* monday... */
DAYOFWEEK() /* 1 */
DAYOFYEAR();
MONTHNAME();
HOUR();
MINUTE();

DATE_FORMAT(); /* %M for month name, %m for month number, %W for day name, %w for day number */

SELECT DATE_FORMAT('2009-10-04 22:23:00', '%W %M %Y'); /* Sunday October 2009 */

SELECT DATE_FORMAT(birthdt, '%m/%d/%Y') FROM people; /* MM-DD-YYYY */

TIME_FORMAT();


/* ============================ Date Math =============================== */
SELECT DATEDIFF(A, B); /* diff number of days, A minus B */

SELECT DATE_ADD(NOW(), INTERVAL 1 MINUTE); /* Add 1 min to now */

DATE_SUB();

SELECT birthdt, birthdt + INTERVAL 1 MONTH + INTERVAL 5 HOUR FROM people;

/* ============================= Timestamp ========================== */
TIMESTAMP /* takes less space, only works for 1970-01-01 00:00:01 to 2038-01-19 03:14:07 */

CREATE TABLE comments (content VARCHAR(100), created_at TIMESTAMP DEFAULT NOW());

CREATE TABLE comments2 (content VARCHAR(100), changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP); /* will update time whenever get change, CURRENT_TIMESTAMP is the same with NOW() */








/* ================================ Logical Operators ================================== */
/* != Not equal */ SELECT title, released_year FROM books WHERE released_year != 2017;

/* NOT LIKE */ SELECT title FROM books WHERE title NOT LIKE '%w%';

/* > Greater Than, <, >=, <= */ SELECT * FROM books WHERE released_year > 2000 ORDER BY released_year;

/* &&/AND Logical AND */ SELECT * FROM books WHERE author_lname = 'eggers' && released_year > 2010;

/* ||/OR Logical OR */ SELECT * FROM books WHERE author_lname = 'eggers' || released_year > 2010;

/* BETWEEN x AND y, inclusive */ SELECT * FROM books WHERE released_year BETWEEN 2004 AND 2015; /* can achieve use AND and <= >= */

/* NOT BETWEEN x AND y */ SELECT * FROM books WHERE released_year NOT BETWEEN 2004 AND 2015;

SELECT CAST('2017-05-02' AS DATETIME);

SELECT name, birthdt FROM people WHERE birthdt BETWEEN CAST('1980-01-01' AS DATETIME) AND CAST('1996-11-22' AS DATETIME);

/* IN */ SELECT title, author_lname FROM books WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

/* NOT IN */

/* MODULO */ SELECT title, released_year FROM books WHERE released_year % 2 != 0;

SELECT title, released_year,
	CASE
		WHEN released_year >= 2000 THEN 'Modern Lit'   /* NO COMMA! */
		ELSE '20th Century Lit'
	END AS GENRE
FROM books;

SELECT author_lname, 
	CASE     
		WHEN COUNT(*) = 1 THEN '1 book'     
		ELSE CONCAT(COUNT(*), ' books') 
	END AS COUNT 
FROM books GROUP BY author_lname, author_fname;







/* ============================ Foreign Key ============================= */
CREATE TABLE orders(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	order_date DATE, 
	amount DECIMAL(8, 2), 
	customer_id INT, 
	FOREIGN KEY(customer_id) REFERENCES customers(id)
); /* relating to table cusomers' id */

SELECT * FROM orders WHERE customer_id =
    (
        SELECT id FROM customers
        WHERE last_name='George'
    ); /* this is not good enough, see implicit inner join */



/* =============================== JOIN!!!! ================================*/
/* Cross Join */ 
SELECT * FROM customers, orders; /* Meaningless, every combination of 2 tables */

/* Implicit Inner Join */ 
SELECT first_name, last_name, order_date, amount FROM customers, orders WHERE customers.id = orders.customer_id;

/* Explicit Inner Join */ 
SELECT first_name, last_name, order_date, amount FROM customers 
JOIN orders 
	ON customers.id = orders.customer_id;
	
	
SELECT first_name, last_name, SUM(amount) AS total_spent 
FROM customers 
JOIN orders 
	ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

/* Left Join */
SELECT first_name, last_name, order_date, amount FROM customers 
LEFT JOIN orders 
	ON customers.id = orders.customer_id; /* Takes everthing from left, and matched ones on the right */

SELECT 
    first_name, 
    last_name,
    IFNULL(SUM(amount), 0) AS total_spent /* IFNULL(A,B): if A null, set it to B, if not still A */
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;

/* Right Join */
SELECT first_name, last_name, order_date, amount FROM customers 
RIGHT JOIN orders 
	ON customers.id = orders.customer_id;

/* ON DELETE CASCADE */
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) 
        REFERENCES customers(id)
        ON DELETE CASCADE /* when deleting parent, delete child as well */
);


/* ================ ROUND ================ */
ROUND(AVG(rating), 2) /* roung 2 digits */



/* ================ SECTION 13 Challenges =============== */
/* Challenge 6 */
SELECT first_name, 
	last_name, 
	COUNT(rating) AS COUNT, 
	IFNULL(MIN(rating), 0) AS MIN, 
	IFNULL(MAX(rating), 0) AS MAX, 
	IFNULL(AVG(rating), 0) AS AVG, 
	CASE 
		WHEN COUNT(rating) = 0 THEN 'INACTIVE' 
		ELSE 'ACTIVE' 
	END AS STATUS 
	-- IF(COUNT(rating) = 0, 'INACTIVE', 'ACTIVE') AS STATUS;     statement, if, else
FROM reviewers 
LEFT JOIN reviews 
	ON reviewers.id = reviews.reviewer_id 
GROUP BY reviewers.id;

/* Challenge 7 */
SELECT title, 
	rating, 
	CONCAT(first_name, ' ', last_name) AS reviewer 
FROM series 
JOIN reviews 
	ON series.id = reviews.series_id 
JOIN reviewers 
	ON reviewers.id = reviews.reviewer_id 
ORDER BY series.id;


