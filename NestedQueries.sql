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
INSERT INTO DEPARTMENT(Dname, Dnumber, MgrSSN, MgrStartDate) VALUES 
('Accounting', 1, '45', '3/13/2023'),
('Services', 2, '97', '5/27/2023'),
('Support', 3, '69', '11/15/2023');
