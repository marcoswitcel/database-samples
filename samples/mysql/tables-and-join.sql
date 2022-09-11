CREATE TABLE person (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name CHAR(60) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE shirt (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    style ENUM('t-shirt', 'polo', 'dress') NOT NULL,
    color ENUM('red', 'blue', 'orange', 'white', 'black') NOT NULL,
    owner SMALLINT UNSIGNED NOT NULL REFERENCES person(id),
    PRIMARY KEY (id)
);

INSERT INTO person VALUES (NULL, 'Antonio Paz');

SELECT @last := LAST_INSERT_ID();

INSERT INTO shirt VALUES
(NULL, 'polo', 'blue', @last),
(NULL, 'dress', 'white', @last),
(NULL, 't-shirt', 'blue', @last);

INSERT INTO person VALUES (NULL, 'Lilliana Angelovska');

SELECT @last := LAST_INSERT_ID();

INSERT INTO shirt VALUES
(NULL, 'dress', 'orange', @last),
(NULL, 'polo', 'red', @last),
(NULL, 'dress', 'blue', @last),
(NULL, 't-shirt', 'white', @last);

SELECT * FROM person;
--  +----+---------------------+
--  | id | name                |
--  +----+---------------------+
--  |  1 | Antonio Paz         |
--  |  2 | Lilliana Angelovska |
--  +----+---------------------+

SELECT * FROM shirt;
--  +----+---------+--------+-------+
--  | id | style   | color  | owner |
--  +----+---------+--------+-------+
--  |  1 | polo    | blue   |     1 |
--  |  2 | dress   | white  |     1 |
--  |  3 | t-shirt | blue   |     1 |
--  |  4 | dress   | orange |     2 |
--  |  5 | polo    | red    |     2 |
--  |  6 | dress   | blue   |     2 |
--  |  7 | t-shirt | white  |     2 |
--  +----+---------+--------+-------+


SELECT s.* FROM person p INNER JOIN shirt s
   ON s.owner = p.id
 WHERE p.name LIKE 'Lilliana%'
   AND s.color <> 'white';

--  +----+-------+--------+-------+
--  | id | style | color  | owner |
--  +----+-------+--------+-------+
--  |  4 | dress | orange |     2 |
--  |  5 | polo  | red    |     2 |
--  |  6 | dress | blue   |     2 |
--  +----+-------+--------+-------+