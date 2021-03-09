-- Payment method: Credit card, Transfer

-- DROP TABLE payment;
TRUNCATE TABLE payment;

CREATE TABLE payment (
foglalas_mod TEXT,
paymentja TEXT,
summed INTEGER);


TRUNCATE TABLE payment;
COPY payment FROM '/home/matt/automation/report_payment.csv' DELIMITER ';';


-- Emails

--DROP TABLE emails;
TRUNCATE TABLE emails;

CREATE TABLE emails (
domain TEXT,
summed INTEGER);


TRUNCATE TABLE emails;
COPY emails FROM '/home/matt/automation/report_email.csv' DELIMITER ',';


-- Cities

-- DROP TABLE cities;
TRUNCATE TABLE cities;

CREATE TABLE cities(
city TEXT,
summed INTEGER);


TRUNCATE TABLE cities;
COPY cities FROM '/home/matt/automation/report_cities.csv' DELIMITER ',';


-- Ordered items

-- DROP TABLE orders;
TRUNCATE TABLE orders;

CREATE TABLE orders(
my_date DATE,
foglalas_mod TEXT,
alap INTEGER,
exkluziv INTEGER,
premium INTEGER,
summed INTEGER);


TRUNCATE TABLE orders;
\COPY orders FROM '/home/matt/automation/report_ordered_items.csv' DELIMITER ',';

-- example
-- INSERT INTO orders VALUES
-- ('2020-08-27','ajandekkartya',9,9,9,9),
-- ('2020-08-27','foglalas',9,9,9,9);


-- Weekly breakdown version 2

-- DROP TABLE orders;
TRUNCATE TABLE orders_2_version;

CREATE TABLE orders_2_version(
my_date DATE,
termek TEXT,
ajandek INTEGER,
idopont INTEGER,
summed INTEGER);


TRUNCATE TABLE orders_2_version;
\COPY orders_2_version FROM '/home/matt/automation/report_weekly_breakdown.csv' DELIMITER ',';