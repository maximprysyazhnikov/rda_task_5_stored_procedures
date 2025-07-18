-- Видаляємо базу, якщо вона вже існує
DROP DATABASE IF EXISTS ShopDB;

-- Створюємо нову базу
CREATE DATABASE ShopDB;
USE ShopDB;

-- Таблиці (можна не створювати вручну, якщо вже є, але покажу для повноти)
CREATE TABLE Products (
    ID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Warehouses (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255),
    CountryID INT
);

CREATE TABLE ProductInventory (
    ID INT PRIMARY KEY,
    ProductID INT,
    WarehouseAmount INT,
    WarehouseID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(ID)
);

-- Тепер створимо збережену процедуру
DELIMITER $$

CREATE PROCEDURE get_warehouse_product_inventory(IN warehouse_id INT)
BEGIN
    SELECT
        p.Name AS ProductName,
        pi.WarehouseAmount AS Amount
    FROM
        ProductInventory pi
    JOIN
        Products p ON pi.ProductID = p.ID
    WHERE
        pi.WarehouseID = warehouse_id;
END $$

DELIMITER ;
