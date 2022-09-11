/*
* https://dev.mysql.com/doc/refman/8.0/en/create-view.html
* https://stackoverflow.com/questions/8233746/concatenate-with-null-values-in-sql
*/

CREATE TABLE pessoas (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(200) NOT NULL,
  nome_do_meio VARCHAR(200) NULL,
  sobrenome VARCHAR(200) NOT NULL,
  PRIMARY KEY(id)
);

INSERT INTO pessoas (nome, nome_do_meio, sobrenome)
  VALUES
    ("Marcos", "de", "Vargas"),
    ("Jaime", NULL, "Kibber");


-- ----------------------
-- EXEMPLOS DE SELECT
-- ----------------------
SELECT CONCAT(nome, " ", COALESCE(nome_do_meio, ""), " ", sobrenome) as nome_completo
  FROM pessoas;

SELECT CONCAT_WS(" ", nome, nome_do_meio, sobrenome) as nome_completo
  FROM pessoas;

CREATE VIEW v_pessoas AS
  SELECT id, nome, nome_do_meio, sobrenome, CONCAT_WS(" ", nome, nome_do_meio, sobrenome) as nome_completo
    FROM pessoas;
