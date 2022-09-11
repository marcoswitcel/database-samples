
CREATE DATABASE PrimeiroExemplo;

USE PrimeiroExemplo;

CREATE TABLE periodicos  (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome_periodico VARCHAR(20),
  issn INT,
  id_editora INT
);

CREATE TABLE editora (
  id INTEGER AUTO_INCREMENT,
  nome_editora VARCHAR(120) UNIQUE,
  pais VARCHAR(5),
  PRIMARY KEY(id)
);


ALTER TABLE periodicos
  ADD CONSTRAINT fk_editora_periodico
  FOREIGN KEY (id_editora) REFERENCES editora(id);

