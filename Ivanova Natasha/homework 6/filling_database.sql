DELIMITER //
CREATE PROCEDURE populate_clients(IN number_of_rows INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO clients(first_name, second_name, vk_id, registration_dttm, status) 
            VALUES (CONCAT('first_name - ', i),
	                CONCAT('second_name - ', i),
	                CONCAT('vk_id - ', i),
	                DATE(NOW() - INTERVAL FLOOR(RAND() * 10) HOUR - INTERVAL FLOOR(RAND() * 20) DAY - INTERVAL FLOOR(RAND() * 10) MONTH),
				    CEIL(RAND() * 10));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END
//

CREATE PROCEDURE populate_providers(IN number_of_rows INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO providers(name, email, phone_number) 
            VALUES (CONCAT('name - ', i),
	                CONCAT('email', i),
	                CONCAT('phone_number - ', i));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END
//

CREATE PROCEDURE populate_workers(IN number_of_rows INT, IN role_id INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO workers(first_name, second_name, vk_id, first_day_dttm, phone_number, role) 
            VALUES (CONCAT('first_name - ', i),
	                CONCAT('second_name - ', i),
	                CONCAT('vk_id - ', i),
				    DATE(NOW() - INTERVAL FLOOR(RAND() * 10) HOUR - INTERVAL FLOOR(RAND() * 20) DAY - INTERVAL FLOOR(RAND() * 10) MONTH),
				    CONCAT('phone_number - ', i),
                    role_id);
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END
//



CREATE PROCEDURE populate_shifts(IN number_of_rows INT)
    BEGIN
        DECLARE i INT;
        DECLARE data DATE;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            SET data = DATE( NOW() - INTERVAL FLOOR(i) DAY);
            INSERT INTO shifts(start_dttm, end_dttm)
            VALUES (data - INTERVAL FLOOR(8) HOUR,
                    data + INTERVAL FLOOR(4) HOUR);
            SET i = i + 1; 
        END WHILE;
        COMMIT;
    END
//

CREATE PROCEDURE populate_visits(IN number_of_rows INT, IN number_of_clients INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO visits(dttm, client) 
            VALUES (DATE(NOW() - INTERVAL FLOOR(RAND() * 10) HOUR - INTERVAL FLOOR(RAND() * 20) DAY - INTERVAL FLOOR(RAND() * 10) MONTH),
				    CEIL(RAND() * number_of_clients));
            SET i = i + 1; 
        END WHILE;
        COMMIT;
    END
//

CREATE PROCEDURE populate_ingredients(IN number_of_rows INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO ingredients(name, price, provider) 
            VALUES (CONCAT('ingredient_name - ', i),
	                CEIL(RAND() * 100),
				    CEIL(RAND() * 10));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END
//

CREATE PROCEDURE populate_items(IN number_of_rows INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO items(name, price) 
            VALUES (CONCAT('item_name - ', i),
	                CEIL(RAND() * 1000));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END
//

CREATE PROCEDURE populate_orders(IN number_of_rows INT, IN number_of_clients INT, IN number_of_workers INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO orders(client, total_price, dttm, worker) 
            VALUES (CEIL(RAND() * number_of_clients),
            		CEIL(RAND() * 1000),
            		DATE(NOW() - INTERVAL FLOOR(RAND() * 10) HOUR - INTERVAL FLOOR(RAND() * 20) DAY - INTERVAL FLOOR(RAND() * 10) MONTH),
                    CONCAT(CEIL(RAND() * number_of_workers)));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END
//

CREATE PROCEDURE populate_order_item_link(IN number_of_rows INT, IN number_of_items INT, IN number_of_orders INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO order_item_link(item, order_id) 
            VALUES (CEIL(RAND() * number_of_items),
	                CEIL(RAND() * number_of_orders));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END
//

CREATE PROCEDURE populate_ingredient_item_link(IN number_of_rows INT, IN number_of_items INT, IN number_of_ingredients INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO ingredient_item_link(ingredient, item, quantity) 
            VALUES (CEIL(RAND() * number_of_ingredients),
	                CEIL(RAND() * number_of_items),
	                CEIL(RAND() * 4));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END
//

CREATE PROCEDURE populate_worker_shift_link(IN number_of_rows INT, IN number_of_workers INT, IN number_of_shifts INT)
    BEGIN
        DECLARE i INT;
        SET i = 1;
        START TRANSACTION;
        WHILE i <= number_of_rows DO
            INSERT INTO worker_shift_link(worker, shift) 
            VALUES (CEIL(RAND() * number_of_workers),
	                CEIL(RAND() * number_of_shifts));
            SET i = i + 1;
        END WHILE;
        COMMIT;
    END
//
DELIMITER ;


INSERT INTO statuses(name, discount) 
VALUES ("basic customer's lavel", 0);

INSERT INTO statuses(name, discount) 
VALUES ("silver customer's lavel", 5);

INSERT INTO statuses(name, discount) 
VALUES ("golden customer's lavel", 10);

INSERT INTO statuses(name, discount) 
VALUES ("diamond customer's lavel", 15);



INSERT INTO roles(name, money_per_hour) 
VALUES ("barista", 300);

INSERT INTO roles(name, money_per_hour) 
VALUES ("manager", 1000);

INSERT INTO roles(name, money_per_hour) 
VALUES ("deputy manager", 700);

INSERT INTO roles(name, money_per_hour) 
VALUES ("chef", 700);

INSERT INTO roles(name, money_per_hour) 
VALUES ("waiter", 300);

CALL populate_clients(800);
CALL populate_providers(10);

CALL populate_workers(4, 1);
CALL populate_workers(1, 2);
CALL populate_workers(3, 4);
CALL populate_workers(10, 5);
CALL populate_workers(1, 3);

CALL populate_shifts(2000);
CALL populate_visits(16000, 800);
CALL populate_ingredients(30);
CALL populate_items(30);
CALL populate_orders(25000, 800, 19);
CALL populate_order_item_link(70000, 30, 25000);
CALL populate_ingredient_item_link(200, 30, 30);
CALL populate_worker_shift_link(10000, 19, 2000);