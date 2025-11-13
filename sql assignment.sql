#Introduction to SQL and Advanced Functions | Assignment


Question 1 : Explain the fundamental differences between DDL, DML, and DQL commands in SQL. Provide one example for each type of command.

Ans- DDL, DML, and DQL are categories of SQL commands serving distinct purposes in database management.
DDL (Data Definition Language) commands are used to define, modify, and manage the structure of database objects. These commands affect the database schema itself, not the data within it. Changes made by DDL commands are typically permanent and auto-committed.
•	Example: Creating a new table.
    CREATE TABLE Students (
        StudentID INT PRIMARY KEY,
        FirstName VARCHAR(50),
        LastName VARCHAR(50)
    );
DML (Data Manipulation Language) commands are used to manage and manipulate the actual data stored within the database tables. These commands affect the rows and values within existing tables. Changes made by DML commands are transactional and can be rolled back if necessary.
•	Example: Inserting a new record into a table.
    INSERT INTO Students (StudentID, FirstName, LastName) VALUES (1, 'Alice', 'Smith');
DQL (Data Query Language) commands are specifically used to retrieve data from the database. While sometimes considered a subset of DML, DQL focuses solely on querying and does not modify the data. 
•	Example: Retrieving all records from a table.

    SELECT * FROM Students;
Question 2 : What is the purpose of SQL constraints? Name and describe three common types of constraints, providing a simple scenario where each would be useful.
SQL constraints are rules applied to columns or tables in a database to enforce data integrity and ensure the accuracy and reliability of the stored information. They define the permissible data values and relationships, preventing the insertion or update of invalid or inconsistent data.
Here are three common types of constraints:
•	PRIMARY KEY Constraint:
o	Description: A PRIMARY KEY uniquely identifies each row in a table. It must contain unique values and cannot contain NULL values. A table can have only one PRIMARY KEY.
o	Scenario: In a Customers table, the customer_id column would be an ideal candidate for a PRIMARY KEY. This ensures that each customer has a unique identifier and that no two customers share the same customer_id.

    CREATE TABLE Customers (
        customer_id INT PRIMARY KEY,
        customer_name VARCHAR(255),
        email VARCHAR(255)
    );
•	FOREIGN KEY Constraint:
o	Description: A FOREIGN KEY establishes a link between two tables. It references the PRIMARY KEY of another table, ensuring referential integrity – meaning that a value in the foreign key column must exist as a primary key value in the referenced table.
o	Scenario: In an Orders table, customer_id could be a FOREIGN KEY referencing the customer_id in the Customers table. This prevents an order from being placed for a non-existent customer.

    CREATE TABLE Orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        order_date DATE,
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    );
•	NOT NULL Constraint:
o	Description: The NOT NULL constraint ensures that a column cannot contain NULL values. It requires that a value always be provided for that column when a new row is inserted or an existing row is updated. 
o	Scenario: In a Products table, the product_name column should be NOT NULL. This guarantees that every product in the database has a name, preventing data incompleteness.
    CREATE TABLE Products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(255) NOT NULL,
        price DECIMAL(10, 2)
    );
Question 3 : Explain the difference between LIMIT and OFFSET clauses in SQL. 
How would you use them together to retrieve the third page of results, assuming each page has 10 records?

Ans- The LIMIT and OFFSET clauses in SQL are used for controlling the number of rows returned by a query and for pagination.
LIMIT Clause:
The LIMIT clause specifies the maximum number of rows that should be returned by the query. It directly restricts the size of the result set.
OFFSET Clause:
The OFFSET clause specifies the number of rows to skip from the beginning of the result set before applying the LIMIT clause. It effectively shifts the starting point of the returned rows. 
Using LIMIT and OFFSET for Pagination (Third Page, 10 Records per page):
To retrieve the third page of results, assuming each page has 10 records, the following steps are required:
•	Calculate the OFFSET: For the third page, you need to skip the first two pages. Since each page has 10 records, you need to skip 2 * 10 = 20 records.
•	Set the LIMIT: The limit remains 10, as you want 10 records per page.
SELECT *
FROM your_table_name
ORDER BY some_column -- It's crucial to use ORDER BY for consistent pagination
LIMIT 10 OFFSET 20;
Explanation:
•	SELECT * FROM your_table_name: This selects all columns from your specified table.
•	ORDER BY some_column: This is essential for consistent pagination. Without an ORDER BY clause, the order of rows might not be predictable, leading to inconsistent page results. Replace some_column with the column you want to sort by.
•	LIMIT 10: This ensures that only 10 rows are returned for the current page.
•	OFFSET 20: This skips the first 20 rows of the ordered result set, effectively starting the selection from the 21st row, which corresponds to the beginning of the third page.

Question 4 : What is a Common Table Expression (CTE) in SQL, 
and what are its main benefits? Provide a simple SQL example demonstrating its usage.

Ans- A Common Table Expression (CTE) in SQL is a temporary, named result set defined within the execution scope of a single SQL statement (SELECT, INSERT, UPDATE, DELETE, or MERGE). It functions like a virtual table, existing only for the duration of the query in which it is defined. CTEs are introduced using the WITH clause. 
Main Benefits of CTEs:
•	Improved Readability and Organization: 
CTEs allow you to break down complex queries into smaller, more manageable logical blocks, making the SQL code easier to understand and follow.
•	Enhanced Maintainability: 
By compartmentalizing query logic, changes to specific parts of a complex query can be isolated within a CTE, reducing the risk of unintended side effects and simplifying maintenance.
•	Reusability: 
A CTE can be referenced multiple times within the same query without having to rewrite the subquery logic, adhering to the "Don't Repeat Yourself" (DRY) principle.
•	Support for Recursive Queries: 
CTEs are essential for handling hierarchical or tree-structured data by allowing recursive queries, where a CTE can reference itself.
Simple SQL Example Demonstrating Usage:
Consider a table named Employees with columns EmployeeID, Name, Department, and Salary. We want to find the average salary per department and then list all employees whose salary is above the average for their respective department.
WITH DepartmentAverageSalary AS (
    SELECT
        Department,
        AVG(Salary) AS AvgSalary
    FROM
        Employees
    GROUP BY
        Department
)
SELECT
    E.Name,
    E.Department,
    E.Salary,
    DAS.AvgSalary
FROM
    Employees E
JOIN
    DepartmentAverageSalary DAS ON E.Department = DAS.Department
WHERE
    E.Salary > DAS.AvgSalary;
In this example:
•	The DepartmentAverageSalary CTE calculates the average salary for each department.
•	The main SELECT statement then joins the Employees table with this CTE to filter and retrieve employees whose salary exceeds their department's average.

Question 5 : Describe the concept of SQL Normalization and its primary goals.
 Briefly explain the first three normal forms (1NF, 2NF, 3NF).
 
Ans --SQL Normalization is a database design technique used to organize tables and columns in a relational database to minimize data redundancy and improve data integrity.
Primary Goals of Normalization:
•	Reduce Data Redundancy: 
Eliminate duplicate data, saving storage space and preventing inconsistencies.
•	Improve Data Integrity: 
Ensure data accuracy and consistency by reducing the chance of anomalies during insertion, updates, or deletions.
•	Enhance Data Management: 
Simplify data maintenance and manipulation, making the database easier to understand and manage.
•	Improve Query Performance: 
Optimized data structure can lead to more efficient queries.
First Three Normal Forms:
•	First Normal Form (1NF):
•	Eliminates repeating groups within rows.
•	Each column contains atomic (indivisible) values.
•	Each row is uniquely identified by a primary key.
•	Second Normal Form (2NF):
•	Must already be in 1NF.
•	Eliminates partial dependencies, meaning all non-key attributes must be fully functionally dependent on the entire primary key. If a table has a composite primary key, no non-key attribute should depend on only a part of that key.
•	Third Normal Form (3NF):
•	Must already be in 2NF.
•	Eliminates transitive dependencies, meaning no non-key attribute should be functionally dependent on another non-key attribute. All non-key attributes should directly depend on the primary key, not on other non-key at

#Question 6 : Create a database named ECommerceDB and perform the following
tasks:
1. Create the following tables with appropriate data types and constraints:
● Categories
○ CategoryID (INT, PRIMARY KEY)
○ CategoryName (VARCHAR(50), NOT NULL, UNIQUE)
● Products
○ ProductID (INT, PRIMARY KEY)
○ ProductName (VARCHAR(100), NOT NULL, UNIQUE)
○ CategoryID (INT, FOREIGN KEY → Categories)
○ Price (DECIMAL(10,2), NOT NULL)
○ StockQuantity (INT)
● Customers
○ CustomerID (INT, PRIMARY KEY)
○ CustomerName (VARCHAR(100), NOT NULL)
○ Email (VARCHAR(100), UNIQUE)
○ JoinDate (DATE)
● Orders
○ OrderID (INT, PRIMARY KEY)
○ CustomerID (INT, FOREIGN KEY → Customers)
○ OrderDate (DATE, NOT NULL)
○ TotalAmount (DECIMAL(10,2))
2. Insert the following records into each table
● Categories
CategoryID Category Name
1 Electronics
2 Books
3 Home Goods
4 Apparel
● Products
ProductID ProductName CategoryID Price StockQuantity
101 Laptop Pro 1 1200.00 50
102 SQL
Handbook
2 45.50 200
103 Smart Speaker 1 99.99 150
104 Coffee Maker 3 75.00 80
105 Novel : The
Great SQL
2 25.00 120
106 Wireless
Earbuds
1 150.00 100
107 Blender X 3 120.00 60
108 T-Shirt Casual 4 20.00 300
● Customers
CustomerID CustomerName Email Joining Date
1 Alice Wonderland alice@example.com 2023-01-10
2 Bob the Builder bob@example.com 2022-11-25
3 Charlie Chaplin charlie@example.com 2023-03-01
4 Diana Prince diana@example.com 2021-04-26
● Orders
OrderID CustomerID OrderDate TotalAmount
1001 1 2023-04-26 1245.50
1002 2 2023-10-12 99.99
1003 1 2023-07-01 145.00
1004 3 2023-01-14 150.00
1005 2 2023-09-24 120.00
1006 1 2023-06-19 20.00

#ans-
-- Create the database
CREATE DATABASE IF NOT EXISTS ECommerceDB;

-- Use the newly created database
USE ECommerceDB;

-- 1. Create the tables

-- Create Categories table
CREATE TABLE IF NOT EXISTS Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

-- Create Products table
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create Customers table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);

-- Create Orders table
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 2. Insert records into each table

-- Insert data into Categories
INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');

-- Insert data into Products
INSERT INTO Products (ProductID, ProductName, CategoryID, Price, StockQuantity) VALUES
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel : The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);

-- Insert data into Customers
INSERT INTO Customers (CustomerID, CustomerName, Email, JoinDate) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');

-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);

#Question 7 : Generate a report showing CustomerName, Email, and the
TotalNumberofOrders for each customer. Include customers who have not placed
any orders, in which case their TotalNumberofOrders should be 0. Order the results
by CustomerName.

ans-

SELECT 
    c.first_name AS customer_name,
    c.email,
    COALESCE(COUNT(r.rental_id), 0) AS total_orders
FROM 
    customer c
LEFT JOIN 
    rental r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.email
ORDER BY 
    c.first_name;
    
    
    #Question 8 : Retrieve Product Information with Category: Write a SQL query to
display the ProductName, Price, StockQuantity, and CategoryName for all
products. Order the results by CategoryName and then ProductName alphabetically.
 ans- 
 
 SELECT 
    f.title AS product_name,
    f.rental_rate AS price,
    f.length AS stock_quantity,
    c.name AS category_name
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
ORDER BY c.name, f.title;

#Question 9 : Write a SQL query that uses a Common Table Expression (CTE) and a
Window Function (specifically ROW_NUMBER() or RANK()) to display the
CategoryName, ProductName, and Price for the top 2 most expensive products in
each CategoryName.

ans-
WITH ProductRank AS (
    SELECT
        c.category_name,
        p.product_name,
        p.price,
        RANK() OVER (PARTITION BY c.category_name ORDER BY p.price DESC) AS price_rank,
        ROW_NUMBER() OVER (PARTITION BY c.category_name ORDER BY p.price DESC) AS row_num
    FROM product p
    JOIN category c
        ON p.category_id = c.category_id
)
SELECT
    category_name,
    product_name,
    price,
    price_rank,
    row_num
FROM ProductRank
WHERE price_rank <= 2
ORDER BY category_name, price DESC;

#Question 10 : You are hired as a data analyst by Sakila Video Rentals, a global movie
rental company. The management team is looking to improve decision-making by
analyzing existing customer, rental, and inventory data.
Using the Sakila database, answer the following business questions to support key strategic
initiatives.
Tasks & Questions:
1. Identify the top 5 customers based on the total amount they’ve spent. Include customer
name, email, and total amount spent.
2. Which 3 movie categories have the highest rental counts? Display the category name
and number of times movies from that category were rented.
3. Calculate how many films are available at each store and how many of those have
never been rented.
4. Show the total revenue per month for the year 2023 to analyze business seasonality.
5. Identify customers who have rented more than 10 times in the last 6 months.

ans-

----------------------------------------------
BDA SUM 75
----------------------------------------------
Section-2
Q7
Dallas Velo Retail Analysis
----------------------------------------------
USE sales;
----------------------------------------------
1.) Identify the top 5 customers based on the total amount they've spent.
(Include customer name, mail id, total amount spent.)
----------------------------------------------
SELECT 
    CONCAT(c.first_name,' ',c.last_name) AS CustomerName,
    c.email,
    SUM(p.amount) AS TotalAmountSpent
FROM payment p
JOIN customer c ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY TotalAmountSpent DESC
LIMIT 5;
----------------------------------------------
2.) Which 3 item categories have the highest rental counts?
(Display the category name and number of times movies from that category were rented.)
----------------------------------------------
SELECT 
    c.name AS CategoryName,
    COUNT(r.rental_id) AS RentalCount
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN inventory i ON i.film_id = fc.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY c.category_id, c.name
ORDER BY RentalCount DESC
LIMIT 3;
----------------------------------------------
3.) Calculate how many bikes are available at each store
(Show how many of these bikes are brand new.)
----------------------------------------------
SELECT
    COUNT(i.inventory_id) AS TotalBikes,
    COUNT(CASE WHEN i.store_id = 1 AND i.inventory_id IS NOT NULL THEN 1 END) AS NewBikesAvail
FROM inventory i
WHERE i.store_id = 1
GROUP BY i.store_id, i.inventory_id;
----------------------------------------------
4.) Show the total revenue per month for the year 2021
----------------------------------------------
SELECT
    EXTRACT(MONTH FROM p.date) AS Month,
    SUM(p.amount) AS TotalRevenue
FROM payment p
WHERE EXTRACT(YEAR FROM p.date) = 2021
GROUP BY Month
ORDER BY Month;
----------------------------------------------
5.) Identify customers who have rented more than 10 films in the last 6 months.
----------------------------------------------
SELECT
    CONCAT(c.first_name,' ',c.last_name) AS CustomerName,
    COUNT(r.rental_id) AS TotalRented
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
WHERE
    r.rental_date >= (CURRENT_DATE - INTERVAL 6 MONTH)
GROUP BY c.customer_id
HAVING TotalRented > 10;
----------------------------------------------
 
 