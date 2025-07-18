DROP DATABASE IF EXISTS ShopDB;


CREATE DATABASE ShopDB;
USE ShopDB;



CREATE TABLE Countries (
    ID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Products (
    ID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Warehouses (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    CountryID INT,
    FOREIGN KEY (CountryID) REFERENCES Countries(ID)
);

CREATE TABLE ProductInventory (
    ID INT PRIMARY KEY,
    ProductID INT,
    WarehouseAmount INT,
    WarehouseID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID)
);

DELIMITER $$

CREATE PROCEDURE get_warehouse_product_inventory(IN warehouse_id INT)
BEGIN
    SELECT 
        p.Name,
        pi.WarehouseAmount
    FROM 
        ProductInventory pi
    JOIN 
        Products p ON pi.ProductID = p.ID
    WHERE 
        pi.WarehouseID = warehouse_id;
END $$

DELIMITER ;