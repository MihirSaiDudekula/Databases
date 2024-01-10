CREATE TABLE Restaurants (
    id int(15),
    Name varchar(50) NOT NULL,
    phone int(10) UNIQUE,
    -- building varchar(50),
    -- street varchar(50),
    -- area varchar(50),
    address varchar(100),
    pincode int(6) DEFAULT 560068,
    cuisine varchar(50),
    -- nblandmark varchar(50),
    -- famousfor varchar(50),
    onlineDelivery bool,
    age int,
    CHECK (age>=18),
  --if it fails - CHECK constraint failed: age>=18
    PRIMARY KEY (id)
  -- primary key combines not null and unique

);

--Insert
INSERT INTO Restaurants VALUES
(1, 'McDonalds',69,'12 BEL Road',560068,"Fast food",True,19);
--missing even a single entry causes a syntax error

INSERT INTO Restaurants(id,name,phone) VALUES
(2, 'Burger King',42);
--if we want to specify (default only works here)
