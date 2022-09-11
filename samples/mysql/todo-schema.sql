
CREATE TABLE list (
  `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE item (
  `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `list_id` INTEGER UNSIGNED NOT NULL ,
  `title` VARCHAR(200) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT fk_list_item FOREIGN KEY (list_id) REFERENCES list(id)
);

INSERT INTO list values(NULL, 'Primeira lista');

SELECT @last := LAST_INSERT_ID();

INSERT INTO
    `item` (title, list_id, description)
  values
    (SUBSTR(MD5(RAND()), 1, 8), @last, ''),
    (SUBSTR(MD5(RAND()), 1, 8), @last, ''),
    (SUBSTR(MD5(RAND()), 1, 8), @last, ''),
    (SUBSTR(MD5(RAND()), 1, 8), @last, ''),
    (SUBSTR(MD5(RAND()), 1, 8), @last, '');