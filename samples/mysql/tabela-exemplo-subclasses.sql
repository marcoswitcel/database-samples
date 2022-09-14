/*
* Exemplo básico de classe e supclasse com implementação (DDL)
* exemplo de insert e de view com INNER JOIN configurado
*/

CREATE TABLE empregado (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(200) NOT NULL,
  nome_do_meio VARCHAR(200) NULL,
  sobrenome VARCHAR(200) NOT NULL,
  tipo_empregado ENUM('tecnico', 'secretaria') NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE secretaria (
  `id` INTEGER UNSIGNED NOT NULL,
  ppm INTEGER NOT NULL,
  grade VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT fk_empregado_secretaria FOREIGN KEY (id) REFERENCES empregado(id)
);

CREATE TABLE tecnico (
  `id` INTEGER UNSIGNED NOT NULL,
  grade VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT fk_empregado_tecnico FOREIGN KEY (id) REFERENCES empregado(id)
);

INSERT INTO empregado VALUES (NULL, 'joão', NULL, 'witcel', 'secretaria');
SELECT @last := LAST_INSERT_ID();
INSERT INTO secretaria VALUES (@last, 33, 'Técnico em Informática');

INSERT INTO empregado VALUES (NULL, 'joão', NULL, 'witcel', 'tecnico');
SELECT @last := LAST_INSERT_ID();
INSERT INTO tecnico VALUES (@last, 'Técnico em Informática');

/*
* VIEWS para facilitar a visualização dos dados
*/

CREATE VIEW v_tecnico AS
  SELECT e.*, CONCAT_WS(" ", e.nome, e.nome_do_meio, e.sobrenome) as nome_completo, t.grade
    FROM empregado e
    INNER JOIN tecnico t ON e.id = t.id;

CREATE VIEW v_secretaria AS
  SELECT e.*, CONCAT_WS(" ", e.nome, e.nome_do_meio, e.sobrenome) as nome_completo, s.ppm, s.grade
    FROM empregado e
    INNER JOIN secretaria s ON e.id = s.id;
