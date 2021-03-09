#!/usr/bin/env bash

psql -U matt -d postgres -c"TRUNCATE TABLE fizetes_mod;"
psql -U matt -d postgres -c"\COPY fizetes_mod FROM '/home/matt/automation/kimutatas_fizetes_mod.csv' DELIMITER ';';"

psql -U matt -d postgres -c"TRUNCATE TABLE emails;"
psql -U matt -d postgres -c"\COPY emails FROM '/home/matt/automation/kimutatas_email_eloszlas.csv' DELIMITER ',';"

psql -U matt -d postgres -c"TRUNCATE TABLE cities;"
psql -U matt -d postgres -c"\COPY cities FROM '/home/matt/automation/kimutatas_varosok.csv' DELIMITER ',';"

psql -U matt -d postgres -c"TRUNCATE TABLE orders;"
psql -U matt -d postgres -c"\COPY orders FROM '/home/matt/automation/kimutatas_ordered_items.csv' DELIMITER ',';"


psql -U matt -d postgres -c"TRUNCATE TABLE orders_2_version;"
psql -U matt -d postgres -c"\COPY orders_2_version FROM '/home/matt/automation/kimutatas_heti_lebontas_2.csv' DELIMITER ',';"




