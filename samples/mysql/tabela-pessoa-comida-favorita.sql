/*
* Tabela de pessoas com relação de comidas favoritas
*/

CREATE TABLE pessoa (
	id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(200) NOT NULL,
    nome_do_meio VARCHAR(200) NULL,
    sobrenome VARCHAR(200) NOT NULL,  
    CONSTRAINT pk_pessoa PRIMARY KEY (id)
);

CREATE TABLE comida_favorita (
    id SMALLINT UNSIGNED NOT NULL,
    nome VARCHAR(200) NOT NULL,
    CONSTRAINT fk_pessoa_comida_favorita FOREIGN KEY (id) REFERENCES pessoa(id)
);

-- Segue abaixo a consulta que retorna todas as constraints
-- SELECT * FROM information_schema.table_constraints;

INSERT INTO pessoa VALUES (NULL, 'João Marcos', 'de Vargas', 'Witcel');
SELECT @last := LAST_INSERT_ID();
INSERT INTO comida_favorita VALUES (@last, 'Banana');