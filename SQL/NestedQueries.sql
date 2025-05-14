CREATE TABLE EMPLOYEE(
  Fname varchar(20), 
  Lname varchar(20), 
  SSN int(10), 
  Addrs varchar(50), 
  Sex varchar(1)
  CHECK (Sex='M' OR Sex='F'),
  Salary int, 
  SuperSSN int(10), 
  Dno int(10),
  PRIMARY KEY (SSN),
  FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);
CREATE TABLE DEPARTMENT(
  Dname varchar(20), 
  Dnumber int(10), 
  MgrSSN int(10), 
  MgrStartDate date,
  PRIMARY KEY (Dnumber)
);
CREATE TABLE PROJECT(
  Pno int(10), 
  Pname varchar(20), 
  Dnum int(10),
  PRIMARY KEY (Pno),
  FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);
CREATE TABLE WORKS_ON 
( 
 ESSN int(10), 
 Pno int(10), 
 Hours time,
 FOREIGN KEY (Pno) REFERENCES Project(Pno),
 PRIMARY KEY (ESSN,Pno)   
);

CREATE TABLE DEPENDENT (
    Dependent_ID int PRIMARY KEY,
    Dependent_Name varchar(50),
    Relationship varchar(20),
    ESSN int,
    FOREIGN KEY (ESSN) REFERENCES EMPLOYEE(SSN)
);

INSERT INTO DEPARTMENT(Dname, Dnumber, MgrSSN, MgrStartDate) VALUES 
('Accounting', 1, 45, '3/13/2023'),
('Services', 2, 97, '5/27/2023'),
('Support', 3, 69, '11/15/2023');

INSERT INTO EMPLOYEE(Fname, Lname, SSN, Addrs, Sex, Salary, SuperSSN, Dno) VALUES
('Luigi', 'Sutherby', 45, '68856 Lien Place', 'M', 261, 164, 1),
('Curtice', 'Jorez', 97, '4629 Coolidge Road', 'M', 448, 32, 2),
('Bridgette', 'Decruse', 69, '472 Bowman Drive', 'F', 751, 5, 3),
('Feliza', 'Danielczyk', 29, '72238 Debs Lane', 'F', 929, 726, 1),
('Archer', 'Morbey', 10, '9 Pond Circle', 'M', 774, 53, 2);

-- Inserting data into the PROJECT table
INSERT INTO PROJECT(Pno, Pname, Dnum) VALUES
(1, 'Project A', 1),  
(2, 'Project B', 2),  
(3, 'Project C', 3);  

-- Inserting data into the WORKS_ON table
INSERT INTO WORKS_ON(ESSN, Pno, Hours) VALUES
(45, 1, '08:00:00'),  -- Luigi (SSN = 45) working on Project A (Pno = 1)
(97, 2, '07:30:00'),  -- Curtice (SSN = 97) working on Project B (Pno = 2)
(69, 3, '09:00:00'),  -- Bridgette (SSN = 69) working on Project C (Pno = 3)
(29, 1, '06:45:00'),  -- Feliza (SSN = 29) working on Project A (Pno = 1)
(10, 2, '08:30:00');  -- Archer (SSN = 10) working on Project B (Pno = 2)

INSERT INTO DEPENDENT (Dependent_ID, Dependent_Name, Relationship, ESSN) VALUES
(1, 'Alice', 'Spouse', 45),   -- Luigi (SSN = 45) has a dependent named Alice
(2, 'Bob', 'Child', 97),      -- Curtice (SSN = 97) has a dependent named Bob
(3, 'Charlie', 'Child', 97),  -- Curtice (SSN = 97) has another dependent named Charlie
(4, 'David', 'Child', 69),    -- Bridgette (SSN = 69) has a dependent named David
(5, 'Eva', 'Spouse', 29),     -- Feliza (SSN = 29) has a dependent named Eva
(6, 'Fiona', 'Child', 10);    -- Archer (SSN = 10) has a dependent named Fiona

-- For each dept, retreive the dept name and avg salary of all employees working in that department
SELECT 
    Dname,
    AVG(Salary) FROM EMPLOYEE e,DEPARTMENT d WHERE e.Dno = d.Dnumber 
    GROUP BY d.Dname
--or
SELECT D.Dname, AVG(E.Salary) 
FROM DEPARTMENT D
JOIN EMPLOYEE E ON D.Dnumber = E.Dno
GROUP BY D.Dname;
--or
SELECT 
    Dname,
    (SELECT AVG(Salary) FROM EMPLOYEE WHERE Dno = Dnumber) AS AvgSalary
FROM DEPARTMENT;

-- List names of managers who have at least one dependent
SELECT Fname, Lname 
FROM EMPLOYEE WHERE EXISTS
(SELECT * FROM DEPENDENT WHERE Ssn=Essn)
AND EXISTS 
(SELECT * FROM DEPARTMENT WHERE Ssn=MgrSSN);
--or
SELECT Fname, Lname 
FROM EMPLOYEE WHERE Ssn IN 
(SELECT MgrSSN FROM DEPARTMENT WHERE MgrSSN IN 
(SELECT Essn FROM DEPENDENT));


