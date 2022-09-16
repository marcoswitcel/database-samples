
SELECT now() FROM dual;

SHOW CHARACTER SET;

SELECT * FROM information_schema.table_constraints;

-- Busca versão do banco MySQL
SHOW VARIABLES LIKE '%version%';

-- Carregando arquivo para tabela
-- NÃO TESTADO
LOAD DATA  INFILE '<path-to-file>' INTO TABLE employee
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY ';'; 
