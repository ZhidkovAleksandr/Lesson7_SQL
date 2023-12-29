CREATE DATABASE MyFunkDB;

USE MyFunkDB;



CREATE TABLE Employees
(
EmployeeID int auto_increment NOT NULL,
name varchar(20),
telephone varchar(10),
primary key(EmployeeID)		
) ;

CREATE TABLE staff
(
postId int auto_increment NOT NULL,
postName varchar(20),
salary int,
empID int NOT NULL,
primary key(postId),
CONSTRAINT fk_emp_id FOREIGN KEY (empID) 
    REFERENCES Employees (EmployeeID) 		
) ;



CREATE TABLE personalInfo
(infoId int auto_increment,
birthDate date,
married boolean default false,
city varchar(20),
empID int NOT NULL,
primary key (infoId),
FOREIGN KEY (empID) 
    REFERENCES Employees (EmployeeID)

);

INSERT Employees
(name, telephone)
VALUES
('Albert Green', '+1123456'),
('Jack Jackson', '+1123467'),
('Robert Red', +1123489);

INSERT staff
(postName, salary, empID)
VALUES
('director', 10000, 1),
('manager', 7000, 2),
('worker', 5000, 3);

INSERT personalInfo
(birthDate, married, city, empID)
VALUES
('1978-11-20', true, 'Berlin', 1),
('1981-10-21', false, 'Hamburg',2),
('1980-09-15', true, 'Hanover',3);

DELIMITER //
CREATE PROCEDURE get_contact_info()
BEGIN
  SELECT e.name,
  e.telephone,
  p.city
  FROM
  Employees e
  INNER JOIN personalInfo p
  ON e.EmployeeID = p.empID;
END//
DELIMITER ;

CALL get_contact_info;

DELIMITER //
CREATE PROCEDURE get_married_info()
BEGIN
  SELECT e.name,
  e.telephone,
  p.birthDate
  FROM
  Employees e
  INNER JOIN personalInfo p
  ON e.EmployeeID = p.empID
  WHERE NOT p.married;
END//
DELIMITER ;
  
CALL get_married_info; 

  
  DELIMITER //
CREATE PROCEDURE get_manager_info()
BEGIN
  SELECT e.name,
  e.telephone,
  p.birthDate
  FROM
  Employees e
  JOIN personalInfo p
  ON e.EmployeeID = p.empID
  JOIN staff s 
  ON e.EmployeeID = s.empID
  WHERE s.postName = 'manager';
END//
DELIMITER ;

CALL get_manager_info;

USE carsshop;

DELIMITER |
CREATE FUNCTION MinAGE() 
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN (SELECT MIN(cl.age) FROM clients cl);
END
|
DELIMITER ;

select c.model, m.mark,
cl.name,
cl.age 
FROM cars c 
JOIN marks m
ON c.mark_id = m.id
JOIN orders ord
ON c.id = car_id
JOIN clients cl
ON cl.id = ord.client_id
WHERE cl.age = MinAGE();



  