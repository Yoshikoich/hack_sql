H-5

CREATE TABLE COUNTRIES (
    id_country SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE ROLES (
    id_role SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE TAXES (
    id_tax SERIAL PRIMARY KEY,
    percentage DECIMAL(5, 2) NOT NULL
);

CREATE TABLE OFFERS (
    id_offer SERIAL PRIMARY KEY,
    status VARCHAR(255) NOT NULL
);

CREATE TABLE DISCOUNTS (
    id_discount SERIAL PRIMARY KEY,
    status VARCHAR(255) NOT NULL,
    percentage DECIMAL(5, 2) NOT NULL
);

CREATE TABLE PAYMENTS (
    id_payment SERIAL PRIMARY KEY,
    type VARCHAR(255) NOT NULL
);

CREATE TABLE CUSTOMERS (
    id_customer SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    id_country INT REFERENCES COUNTRIES(id_country),
    id_role INT REFERENCES ROLES(id_role),
    name VARCHAR(255) NOT NULL,
    age INT CHECK (age >= 0),
    password VARCHAR(255) NOT NULL,
    physical_address TEXT
);

CREATE TABLE INVOICE_STATUS (
    id_invoice_status SERIAL PRIMARY KEY,
    status VARCHAR(255) NOT NULL
);

CREATE TABLE PRODUCTS (
    id_product SERIAL PRIMARY KEY,
    id_discount INT REFERENCES DISCOUNTS(id_discount),
    id_offer INT REFERENCES OFFERS(id_offer),
    id_tax INT REFERENCES TAXES(id_tax),
    name VARCHAR(255) NOT NULL,
    details TEXT,
    minimum_stock INT CHECK (minimum_stock >= 0),
    maximum_stock INT CHECK (maximum_stock >= 0),
    current_stock INT CHECK (current_stock >= 0),
    price DECIMAL(10, 2) NOT NULL,
    price_with_tax DECIMAL(10, 2) NOT NULL
);

CREATE TABLE PRODUCTS_CUSTOMERS (
    id_product INT REFERENCES PRODUCTS(id_product),
    id_customer INT REFERENCES CUSTOMERS(id_customer),
    PRIMARY KEY (id_product, id_customer)
);

CREATE TABLE INVOICES (
    id_invoice SERIAL PRIMARY KEY,
    id_customer INT REFERENCES CUSTOMERS(id_customer),
    id_payment INT REFERENCES PAYMENTS(id_payment),
    id_invoice_status INT REFERENCES INVOICE_STATUS(id_invoice_status),
    date DATE NOT NULL,
    total_to_pay DECIMAL(10, 2) NOT NULL
);

CREATE TABLE ORDERS (
    id_order SERIAL PRIMARY KEY,
    id_invoice INT REFERENCES INVOICES(id_invoice),
    id_product INT REFERENCES PRODUCTS(id_product),
    detail TEXT,
    amount INT CHECK (amount > 0),
    price DECIMAL(10, 2) NOT NULL
);







H-6


INSERT INTO COUNTRIES (name) VALUES
('Venezuela'),
('Argentina'),
('Mexico');


INSERT INTO ROLES (name) VALUES
('Admin'),
('Customer'),
('Vendor');


INSERT INTO TAXES (percentage) VALUES
(5.00),
(10.00),
(15.00);


INSERT INTO OFFERS (status) VALUES
('Activo'),
('Expirado'),
('Proximo');


INSERT INTO DISCOUNTS (status, percentage) VALUES
('Activo', 10.00),
('Inactivo', 0.00),
('Estacionales', 20.00);


INSERT INTO PAYMENTS (type) VALUES
('Tarjeta de Credito o Debito'),
('PayPal'),
('Transferencia Bancaria');


INSERT INTO CUSTOMERS (email, id_country, id_role, name, age, password, physical_address) VALUES
('ejemplo1@ejemplo.com', 1, 1, 'Maria M', 30, 'pass123', 'Av. Los Libertadores, Venezuela'), 
('ejemplo2@ejemplo.com', 2, 2, 'Juana S', 25, 'pass456', 'Av. Olivos 4109, Argentina'), 
('ejemplo3@ejemplo.com', 3, 3, 'Pedro L', 28, 'pass789', 'Calle Melchor Ocampo, Mexico');


INSERT INTO INVOICE_STATUS (status) VALUES
('Pendiente'),
('Pagado'),
('Cancelado');


INSERT INTO PRODUCTS (id_discount, id_offer, id_tax, name, details, minimum_stock, maximum_stock, current_stock, price, price_with_tax) VALUES
(1, 1, 1, 'Producto A', 'Detalles de Producto A', 10, 100, 50, 100.00, 105.00), 
(2, 2, 2, 'Producto B', 'Detalles de Producto B', 5, 50, 25, 200.00, 220.00), 
(3, 3, 3, 'Producto C', 'Detalles de Producto C', 20, 200, 100, 300.00, 345.00);


INSERT INTO PRODUCTS_CUSTOMERS (id_product, id_customer) VALUES
(1, 1),
(2, 2),
(3, 3);


INSERT INTO INVOICES (id_customer, id_payment, id_invoice_status, date, total_to_pay) VALUES
(1, 1, 1, '2024-07-11', 100.00),
(2, 2, 2, '2024-07-20', 200.00),
(3, 3, 3, '2024-08-01', 300.00);


INSERT INTO ORDERS (id_invoice, id_product, detail, amount, price) VALUES
(1, 1, 'Orden Producto A', 1, 100.00),
(2, 2, 'Orden Producto B', 2, 200.00),
(3, 3, 'Orden Producto C', 3, 300.00);



DELETE FROM PRODUCTS_CUSTOMERS WHERE id_customer = (SELECT MIN(id_customer) FROM CUSTOMERS);

DELETE FROM ORDERS
WHERE id_invoice IN (SELECT id_invoice FROM INVOICES WHERE id_customer = (SELECT MIN(id_customer) FROM CUSTOMERS));

DELETE FROM INVOICES
WHERE id_customer = (SELECT MIN(id_customer) FROM CUSTOMERS);

DELETE FROM CUSTOMERS
WHERE id_customer = (SELECT MIN(id_customer) FROM CUSTOMERS);





SELECT MAX(id_customer) FROM CUSTOMERS;
UPDATE CUSTOMERS
SET name = 'Pepito M', email = 'nuevocorreo@ejemplo.com', age = 40
WHERE id_customer = (SELECT MAX(id_customer) FROM CUSTOMERS);

UPDATE TAXES
SET percentage = percentage + 2.00;

UPDATE PRODUCTS
SET price = price * 1.05,
    price_with_tax = price_with_tax * 1.05;

