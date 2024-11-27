-- Select data base
USE mysql_dump;

-- 1. First 5 client_id with district_id = 1
SELECT TOP 5 bank_disp.account_id, bank_disp.client_id, bank_account.district_id
FROM bank_disp
INNER JOIN bank_account ON bank_disp.account_id=bank_account.account_id
WHERE bank_account.district_id = 1;

-- 2. Last client_id with district_id = 72
SELECT bank_disp.account_id, bank_disp.client_id, bank_account.district_id
FROM bank_disp
INNER JOIN bank_account ON bank_disp.account_id=bank_account.account_id
WHERE bank_account.district_id = 72
ORDER BY bank_disp.client_id desc
LIMIT 1;

-- 3. 3 smallest loans
SELECT amount
from bank_loan
ORDER BY amount asc
LIMIT 3;

-- 4. status alphabetic order from loan table
SELECT DISTINCT status
from bank_loan
order by status asc

-- 5. loan_id for the highest payment
select loan_id
from bank_loan
order by payments desc
limit 1;

-- 6. id and amount of the 5 smallest id
select account_id, amount
from bank_loan
order by account_id asc 
limit 5;

-- 7. account_id with smallest amount with a duration=60
select account_id
from bank_loan
where duration = 60
order by amount asc
limit 5;

-- 8. unique values of k_symbol in the order table
select distinct k_symbol
from bank_order
order by k_symbol asc;

-- 9. order_id for the account_id=34
select order_id
from bank_order
where account_id=34;

-- 10. account_id for the oreder_id between 29540 and 29560
select distinct account_id
from bank_order
where order_id between 29540 and 29560;

-- 11. amount of account_to = 30067122
select distinct amount
from bank_order
where account_to=30067122;

-- 12. trans_id, date, type, amount for the first 10 account_id = 793
select trans_id, date, type, amount
from bank_trans
where account_id=793
order by date desc
limit 10;

-- 13. number of clients for district_id<10
SELECT bank_account.district_id, count(bank_disp.client_id) as total_clients
FROM bank_disp
JOIN bank_account ON bank_disp.account_id=bank_account.account_id
WHERE bank_account.district_id < 10
group by bank_account.district_id
ORDER BY bank_account.district_id asc;

-- 14. cards group by type
SELECT type, count(card_id) as total_cards
FROM bank_card
GROUP BY type
ORDER BY count(card_id) desc;

-- 15. top 10 account_id for the sum of the amounts
SELECT account_id, sum(amount) as total_amounts
FROM bank_loan
GROUP BY account_id
ORDER BY sum(amount) desc
limit 10;

-- 16. number of loans per day before 930907
SELECT date, count(loan_id) as total_loans
FROM bank_loan
where date < 930907
GROUP BY date
ORDER BY date desc;

-- 17. number of loans by duration
SELECT date, duration, count(loan_id) as total_loans
FROM bank_loan
where date >= 971200 AND date < 980100
GROUP BY date, duration
having count(loan_id)<>0
ORDER BY date asc, duration asc;

-- 18. amount for each type
SELECT account_id, type, sum(amount) as total_amount
FROM bank_trans
where account_id = 396
GROUP BY account_id, type
ORDER BY type asc;
