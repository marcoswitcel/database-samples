
CREATE DATABASE teste_union_intersect_except;

USE teste_union_intersect_except;

CREATE TABLE r (
    a char(2)
);

CREATE TABLE s (
    a char(2)
);


INSERT INTO r(a) values ('a1'), ('a2'), ('a2'), ('a3');
INSERT INTO s(a) values ('a1'), ('a1'), ('a2'), ('a3'), ('a4'), ('a5');

SELECT * FROM r;
SELECT * FROM s;

-- Exemplo de EXCEPT
SELECT * FROM r WHERE a NOT IN (SELECT * FROM s); -- Retorna nada
SELECT * FROM s WHERE a NOT IN (SELECT * FROM r); -- Retorna 'a4' e 'a5'

-- Exemplode UNION
(SELECT DISTINCT r.a FROM r) UNION (SELECT DISTINCT s.a FROM s);
(SELECT r.a FROM r) UNION (SELECT s.a FROM s); -- O comando DISTINCT não é necessário no UNION normal, ele já exclui as duplicatas
-- O UNION ALL traz todos os registros sem remover as duplicatas
(SELECT r.a FROM r) UNION ALL (SELECT s.a FROM s);

-- Exemplo de INTERSECT
SELECT * FROM r WHERE a IN (SELECT * FROM s); -- Retorna 'a1' 'a2' 'a2' 'a3'
SELECT * FROM s WHERE a IN (SELECT * FROM r); -- Retorna 'a1' 'a1' 'a2' 'a3'

