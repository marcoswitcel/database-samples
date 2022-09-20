
CREATE DATABASE IF NOT EXISTS company;

USE company;

-- Seria legal criar um domínio customizado, porém o MYSQL
-- não oferece suporte a esse comando. Exempĺo abaixo:
-- CREATE DOMAIN D_num AS INT CHECK(D_num > 0 AND D_num < 21);

-- https://stackoverflow.com/questions/2115497/check-constraint-in-mysql-is-not-working
-- A partir do MySQL 8.0.16 o comando CHECK gera check constraints, antes ele era apenas ignorado, isso quando não causava erro de síntaxe

CREATE TABLE company.employee(
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR,
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    sex CHAR,
    Salary DECIMAL(10, 2),
    Super_ssn char(9),
    Dno INT NOT NULL,
    CONSTRAINT chk_salary_employee CHECK (Salary > 2000.0), -- Constraint de checagem que exige um valor maior que 2000.0 para armazenar o registro
    CONSTRAINT pk_employee PRIMARY KEY (Ssn)
);

-- Select com informação derivada INSS
SELECT Fname, Lname, Salary, round(Salary * 0.11) as INSS FROM employee;
-- Select com busca por valor dentro de um intervalo sem e com o operador BETWEEN
SELECT Fname, Lname, Salary, round(Salary * 0.11) as INSS FROM employee WHERE Salary > 3000 AND Salary < 4000;
SELECT Fname, Lname, Salary, round(Salary * 0.11) as INSS FROM employee WHERE Salary BETWEEN 3000 AND 4000;

CREATE TABLE departament(
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE,
    Dept_create_date Date,
    CONSTRAINT chk_date_departament CHECK (Dept_create_date < Mgr_start_date),
    CONSTRAINT pk_departament PRIMARY KEY (Dnumber),
    CONSTRAINT unique_name_departament UNIQUE (Dname),
    CONSTRAINT fk_departament FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
);

-- Exemplo de alter table 'on update cascade'
-- Caso tentem alterar o id do elemento referência, a atualização será realiza aqui também
-- sem essa configuração o update falharia.
ALTER TABLE departament DROP CONSTRAINT fk_departament;
ALTER TABLE departament
    ADD CONSTRAINT fk_departament
    FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
    ON UPDATE CASCADE;

CREATE TABLE dept_locations(
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dnumber_dept_locations PRIMARY KEY (Dnumber, Dlocation),
    CONSTRAINT fk_dnumber_dept_locations FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
);

-- Exemplo de alter table 'on delete cascade'
-- Nesse caso configuramos uma relação de dependência, se deletar o departamento as localizações
-- associadas serão deletadas também, sem essa configuração seria necessário deletar as localizações
-- para poder deletar o departamento.
ALTER TABLE dept_locations DROP CONSTRAINT fk_dnumber_dept_locations;
ALTER TABLE dept_locations
    ADD CONSTRAINT fk_dnumber_dept_locations
    FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


CREATE TABLE project(
    Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    PRIMARY KEY (Pnumber),
    UNIQUE (Pname),
    FOREIGN KEY (Dnum) REFERENCES departament(Dnumber)
);

CREATE TABLE works_on(
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    PRIMARY KEY(Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn),
    FOREIGN KEY (Pno) REFERENCES project(Pnumber)
);

CREATE TABLE dependent(
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR, -- F ou M
    Bdate DATE,
    Relationship VARCHAR(8),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);

-- Consultas
SELECT `e`.`Fname`, `d`.`Dname` FROM employee e, departament d WHERE (d.Mgr_ssn = e.Ssn);

-- Exemplo de consulta em múltiplas tabelas usando filtragem com where
SELECT * FROM employee e, works_on w, project p WHERE e.Ssn = w.Essn AND w.Pno = p.Pnumber;

-- Subconsultas
SELECT DISTINCT Essn FROM works_on
    WHERE (Pno, Hours) IN (
        SELECT Pno, Hours FROM works_on WHERE Essn = '123456789'
    );

-- Exemplos
-- Consulta que responde a pergunta: Quais funcionários possuem dependentes?
SELECT e.Fname, e.Lname FROM employee as e
    WHERE EXISTS (
        SELECT * FROM dependent as d WHERE e.Ssn = d.Essn AND e.Fname = d.Dependent_name
    );

-- Exemplos de Order By
-- Por padrão os registros não possuem ordenação (são um conjunto), para garantir a ordenação
-- precisamos transformar o conjunto em uma lista ordenada com o ORDER BY
SELECT * FROM employee ORDER BY Fname, Lname; -- Por padrão do menor para o maior (ASC)

SELECT DISTINCT d.Dname, CONCAT_WS(" ", e.Fname, e.Lname) as Manager, Address
    FROM departament as d, employee as e, works_on as w, project as p
    WHERE (d.Dnumber = e.Dno AND e.Ssn = d.Mgr_ssn AND w.Pno = p.Pnumber)
    ORDER BY d.Dname, Manager;

-- Exemplos de agrupamento
SELECT count(*) FROM employee;
SELECT count(*) FROM employee, departament
    WHERE Dno = Dnumber AND Dname = 'Research';
SELECT Dno, count(*) as numero_de_pessoas, round(avg(Salary), 2) as media_salarial  FROM employee
    GROUP BY Dno;
SELECT count(DISTINCT Salary) FROM employee;
SELECT MIN(Salary), MAX(Salary), AVG(Salary), SUM(Salary) FROM employee;
SELECT Pnumber, Pname, count(*) as Number_of_registers, round(avg(Salary)) as AVG_Salary
    FROM project, works_on, employee
    WHERE Pnumber = Pno AND Ssn = Essn
    GROUP BY Pnumber
    ORDER BY count(*);
-- Exemplo de HAVING
SELECT Pnumber, Pname, count(*)
    FROM project, works_on
    WHERE Pnumber = Pno
    GROUP BY Pnumber, Pname
        HAVING count(*) > 2; -- Condição sobre as informações agrupadas
-- Exemplo de CASE
UPDATE employee
    SET Salary = CASE
        WHEN Dno = 5 THEN Salary + 2000
        WHEN Dno = 4 THEN Salary + 1500
        WHEN Dno = 1 THEN Salary + 3000
        ELSE Salary + 0
    END;
