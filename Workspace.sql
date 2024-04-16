BEGIN
    FOR r IN (
        SELECT
            table_name
        FROM
            user_tables
    ) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP TABLE "'
                              || r.table_name
                              || '" CASCADE CONSTRAINTS PURGE';
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Failed to drop table "'
                                     || r.table_name
                                     || '": '
                                     || SQLERRM);
        END;
    END LOOP;

    FOR r IN (
        SELECT
            sequence_name
        FROM
            user_sequences
    ) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP SEQUENCE "'
                              || r.sequence_name
                              || '"';
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Failed to drop sequence "'
                                     || r.sequence_name
                                     || '": '
                                     || SQLERRM);
        END;
    END LOOP;
END;
/

CREATE TABLE gpnr_shipper (
    shipper_username VARCHAR2(20) PRIMARY KEY,
    shipper_email VARCHAR2(255),
    shipper_firstname VARCHAR2(255),
    shipper_lastname VARCHAR2(255),
    shipper_phone VARCHAR2(15)
);

-- gpnr_shipper
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('justin_doe', 'justin.doe@example.com', 'Justin', 'Doe', '1234567890');
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('walter_smith', 'walter.smith@example.com', 'Walter', 'Smith', '1987654321');
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('mike_jones', 'mike.jones@example.com', 'Mike', 'Jones', '1122334455');
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('emily_brown', 'emily.brown@example.com', 'Emily', 'Brown', '1567890123');
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('alex_wilson', 'alex.wilson@example.com', 'Alex', 'Wilson', '1432987654');
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('susan_jackson', 'susan.jackson@example.com', 'Susan', 'Jackson', '1876543210');
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('david_miller', 'david.miller@example.com', 'David', 'Miller', '1789054321');
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('lisa_taylor', 'lisa.taylor@example.com', 'Lisa', 'Taylor', '1908765432');
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('chris_anderson', 'chris.anderson@example.com', 'Chris', 'Anderson', '1654321890');
INSERT INTO gpnr_shipper (shipper_username, shipper_email, shipper_firstname, shipper_lastname, shipper_phone) VALUES ('sophia_thomas', 'sophia.thomas@example.com', 'Sophia', 'Thomas', '1432765432');

CREATE TABLE gpnr_supplier (
    supplier_username VARCHAR2(20) PRIMARY KEY,
    supplier_password VARCHAR2(255),
    supplier_email VARCHAR2(255),
    supplier_firstname VARCHAR2(255),
    supplier_lastname VARCHAR2(255),
    supplier_phone VARCHAR2(15)
);

-- gpnr_supplier
INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('johndoe', 'password123', 'johndoe@example.com', 'John', 'Doe', '1234567890');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('janedoe', 'pass123', 'janedoe@example.com', 'Jane', 'Doe', '4567890123');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('smithclothing', 'clothes123', 'info@smithclothing.com', 'Smith', 'Clothing', '7890123456');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('fashiontrends', 'fashionpass', 'contact@fashiontrends.com', 'Fashion', 'Trends', '0123456789');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('stylishthreads', 'stylish123', 'hello@stylishthreads.com', 'Stylish', 'Threads', '2345678901');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('sportychics', 'chicpass', 'support@sportychics.com', 'Sporty', 'Chics', '5678901234');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('trendyboutique', 'trendypass', 'info@trendyboutique.com', 'Trendy', 'Boutique', '8901234567');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('casualstyles', 'casualpass', 'hello@casualstyles.com', 'Casual', 'Styles', '9012345678');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('elegantwear', 'elegant123', 'info@elegantwear.com', 'Elegant', 'Wear', '3456789012');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('vintagevibes', 'vintagepass', 'contact@vintagevibes.com', 'Vintage', 'Vibes', '6789012345');

CREATE TABLE gpnr_product_attribute (
    product_attribute_id NUMBER(10) PRIMARY KEY,
    product_attribute_name VARCHAR2(255),
    value VARCHAR2(255)
);

-- gpnr_product_attribute
INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (1, 'Color', 'Red');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (2, 'Color', 'Navy Blue');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (3, 'Color', 'Green');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (4, 'Color', 'Yellow');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (5, 'Color', 'Black');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (6, 'Color', 'White');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (7, 'Color', 'Gray');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (8, 'Size', 'Small');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (9, 'Size', 'Medium');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (10, 'Size', 'Large');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (11, 'Material', 'Cotton');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (12, 'Material', 'Polyester');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (13, 'Material', 'Silk');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (14, 'Material', 'Denim');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (15, 'Material', 'Spandex');

CREATE TABLE gpnr_category (
    category_id NUMBER(10) PRIMARY KEY,
    category_name VARCHAR2(255),
    category_description CLOB
);

-- gpnr_category
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (1, 'Clothing', 'A wide range of fashionable clothing items for all occasions.');
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (2, 'Footwear', 'Stylish and comfortable footwear for men, women, and children.');
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (3, 'Accessories', 'Trendy accessories to complement your outfits and add flair to your look.');
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (4, 'Sportswear', 'High-quality sportswear designed for performance and style.');
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (5, 'Formal Wear', 'Elegant attire suitable for formal events and special occasions.');
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (6, 'Casual Wear', 'Comfortable and chic clothing for everyday wear.');
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (7, 'Vintage Fashion', 'Unique and timeless fashion pieces inspired by the past decades.');
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (8, 'Swimwear', 'Fashionable swimwear for lounging by the pool or hitting the beach in style.');
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (9, 'Outerwear', 'Stylish outerwear options to keep you warm and fashionable in any weather.');
INSERT INTO gpnr_category (category_id, category_name, category_description) VALUES (10, 'Loungewear', 'Comfortable and trendy loungewear perfect for relaxing at home or running errands.');

CREATE TABLE gpnr_product (
    product_id NUMBER(10) PRIMARY KEY,
    product_name VARCHAR2(255),
    price NUMBER(12, 2),
    product_quantity NUMBER(10),
    category_id NUMBER(10),
    product_attribute_id NUMBER(10),
    FOREIGN KEY (category_id) REFERENCES gpnr_category(category_id),
    FOREIGN KEY (product_attribute_id) REFERENCES gpnr_product_attribute(product_attribute_id)
);

-- gpnr_product
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (1, 'Red T-Shirt', 19.99, 100, 1, 1);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (2, 'Navy Blue Jeans', 29.99, 75, 1, 14);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (3, 'Green Dress', 39.99, 50, 5, 6);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (4, 'Yellow Hoodie', 34.99, 80, 6, 1);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (5, 'Black Leggings', 24.99, 90, 1, 15);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (6, 'White Sneakers', 49.99, 60, 2, 6);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (7, 'Gray Sweatpants', 29.99, 70, 6, 15);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (8, 'Small Red Backpack', 39.99, 40, 3, 1);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (9, 'Large Navy Blue Socks', 7.29, 30, 9, 3);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (10, 'Large Green Scarf', 19.99, 50, 3, 6);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (11, 'Black Swimsuit', 29.99, 45, 8, 15);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (12, 'White Sunglasses', 14.99, 100, 3, 6);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (13, 'Gray Hat', 9.99, 120, 3, 7);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (14, 'Small Black Gym Bag', 24.99, 80, 4, 5);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (15, 'Medium Navy Blue Yoga Mat', 29.99, 60, 4, 2);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (16, 'Large Green Water Bottle', 19.99, 70, 4, 4);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (17, 'Red Soccer Jersey', 39.99, 40, 4, 1);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (18, 'Navy Blue Basketball Shorts', 24.99, 50, 4, 14);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (19, 'Green Running Shoes', 59.99, 30, 4, 6);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (20, 'Yellow Tennis Skirt', 34.99, 35, 4, 15);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (21, 'Black Baseball Cap', 19.99, 80, 3, 5);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (22, 'White Leather Belt', 29.99, 60, 3, 6);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (23, 'Gray Wool Gloves', 14.99, 100, 3, 7);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (24, 'Small Red Handbag', 39.99, 40, 3, 1);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (25, 'Medium Navy Blue Necktie', 24.99, 50, 5, 14);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (26, 'Large Green Suit', 59.99, 30, 5, 6);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (27, 'Black Dress Shoes', 49.99, 35, 2, 5);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (28, 'White Lace Gloves', 19.99, 70, 5, 6);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (29, 'Gray Bow Tie', 14.99, 100, 5, 7);
INSERT INTO gpnr_product (product_id, product_name, price, product_quantity, category_id, product_attribute_id) VALUES (30, 'Small Red Suspenders', 24.99, 80, 5, 1);

CREATE TABLE gpnr_supplier_product (
    supplier_username VARCHAR2(20),
    product_id NUMBER(10),
    PRIMARY KEY (supplier_username, product_id),
    FOREIGN KEY (supplier_username) REFERENCES gpnr_supplier(supplier_username),
    FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

-- gpnr_supplier_product
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('johndoe', 1);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('johndoe', 6);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('johndoe', 17);

INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('janedoe', 3);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('janedoe', 12);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('janedoe', 25);

INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('smithclothing', 2);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('smithclothing', 7);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('smithclothing', 20);

INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('fashiontrends', 5);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('fashiontrends', 13);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('fashiontrends', 26);

INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('stylishthreads', 4);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('stylishthreads', 11);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('stylishthreads', 24);

INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('sportychics', 10);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('sportychics', 16);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('sportychics', 29);

INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('trendyboutique', 8);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('trendyboutique', 14);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('trendyboutique', 27);

INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('casualstyles', 9);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('casualstyles', 15);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('casualstyles', 28);

INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('elegantwear', 16);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('elegantwear', 22);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('elegantwear', 30);

INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('vintagevibes', 10);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('vintagevibes', 18);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('vintagevibes', 23);

---------------------------------------------------------------------------------------------------------------

CREATE TABLE gpnr_district (
    district_id NUMBER(10) PRIMARY KEY,
    district VARCHAR2(20),
    tax NUMBER(3, 2),
    shipping_cost NUMBER(3, 2)
);

-- gpnr_district
INSERT INTO gpnr_district (district_id, district, tax, shipping_cost) VALUES (1, 'Toronto Central', 0.15, 0.10);
INSERT INTO gpnr_district (district_id, district, tax, shipping_cost) VALUES (2, 'North York', 0.12, 0.05);
INSERT INTO gpnr_district (district_id, district, tax, shipping_cost) VALUES (3, 'Scarborough', 0.18, 0.08);
INSERT INTO gpnr_district (district_id, district, tax, shipping_cost) VALUES (4, 'Etobicoke', 0.10, 0.07);
INSERT INTO gpnr_district (district_id, district, tax, shipping_cost) VALUES (5, 'East York', 0.17, 0.06);
INSERT INTO gpnr_district (district_id, district, tax, shipping_cost) VALUES (6, 'York', 0.20, 0.09);
INSERT INTO gpnr_district (district_id, district, tax, shipping_cost) VALUES (7, 'Mississauga', 0.13, 0.11);
INSERT INTO gpnr_district (district_id, district, tax, shipping_cost) VALUES (8, 'Toronto West', 0.16, 0.12);


CREATE TABLE gpnr_customer (
    customer_username VARCHAR2(20) PRIMARY KEY,
    customer_password VARCHAR2(255),
    customer_email VARCHAR2(255),
    customer_firstname VARCHAR2(255),
    customer_lastname VARCHAR2(255),
    customer_phone VARCHAR2(15),
    customer_address VARCHAR2(255)
);

-- gpnr_customer
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('jane_doe', 'password1231', 'jane_doe@example.com', 'John', 'Doe', '1234567890', '123 Main St, Toronto Central');
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('john_smith', 'p@ssw0rd2', 'john_smith@example.com', 'Jane', 'Smith', '2345678901', '456 Elm St, North York');
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('mike_jones', 'securepass3', 'mike_jones@example.com', 'Mike', 'Johnson', '3456789012', '789 Maple Ave, York');
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('amy_wong', 'password1234', 'amy_wong@example.com', 'Emily', 'Brown', '4567890123', '987 Oak St, Etobicoke');
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('brian_smith', 'brianspassword5', 'brian_smith@example.com', 'Chris', 'Lee', '5678901234', '654 Pine St, East York');
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('sarah_brown', 'sarahpass6', 'sarah_brown@example.com', 'Sarah', 'Taylor', '6789012345', '321 Cedar St, Scarborough');
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('david_kim', 'david1237', 'david_kim@example.com', 'David', 'Clark', '7890123456', '987 Walnut St, Mississauga');
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('lisa_miller', 'lisapassword8', 'lisa_miller@example.com', 'Amanda', 'Martinez', '8901234567', '654 Birch St, Toronto West');
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('kevin_lee', 'kevinpass9', 'kevin_lee@example.com', 'Michael', 'Garcia', '9012345678', '321 Spruce St, Scarborough');
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) VALUES ('emily_taylor', 'emilypass', 'emily_taylor@example.com', 'Jessica', 'Lopez', '0123456789', '789 Oak St, East York');

CREATE TABLE gpnr_request (
    request_id NUMBER(10) PRIMARY KEY,
    request_created_at TIMESTAMP,
    request_status VARCHAR2(255),
    request_cost NUMBER(3, 2),
    message CLOB,
    customer_username VARCHAR2(20),
    FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username)
);

CREATE TABLE gpnr_product_request (
    product_id NUMBER(10),
    request_id NUMBER(10),
    product_request_quantity NUMBER(10),
    PRIMARY KEY (product_id, request_id),
    FOREIGN KEY (request_id) REFERENCES gpnr_request(request_id),
    FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

-- CREATE SEQUENCE seq_gpnr_request_id START WITH 101 INCREMENT BY 1;

-- gpnr_request
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (101, TIMESTAMP '2023-06-16 10:00:00', 'Pending', 0.1, 'Please process this request as soon as possible.', 'jane_doe');
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (102, TIMESTAMP '2023-07-05 11:30:00', 'Approved', 0.2, 'Urgent request. Need immediate attention.', 'john_smith');
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (103, TIMESTAMP '2023-08-20 13:45:00', 'Pending', 0.3, 'This is a test message for the request.', 'mike_jones');
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (104, TIMESTAMP '2023-09-10 15:20:00', 'Rejected', 0.05, 'Request has been rejected due to insufficient funds.', 'amy_wong');
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (105, TIMESTAMP '2023-10-05 08:45:00', 'Approved', 0.1, 'Request approved. Processing will begin shortly.', 'brian_smith');
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (106, TIMESTAMP '2023-11-25 11:30:00', 'Pending', 0.15, 'Please expedite processing for this request.', 'sarah_brown');
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (107, TIMESTAMP '2023-12-10 14:15:00', 'Approved', 0.2, 'Request approved. Payment has been processed.', 'david_kim');
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (108, TIMESTAMP '2024-01-05 09:00:00', 'Pending', 0.25, 'Request is urgent. Please prioritize processing.', 'lisa_miller');
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (109, TIMESTAMP '2024-02-15 13:30:00', 'Rejected', 0.3, 'Request rejected due to incomplete information.', 'kevin_lee');
INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username) VALUES (110, TIMESTAMP '2024-03-20 17:45:00', 'Pending', 0.05, 'Please process this request at the earliest convenience.', 'emily_taylor');

-- gpnr_product_request
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (7, 101, 5);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (8, 101, 3);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (7, 102, 2);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (6, 102, 4);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (20, 103, 7);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (7, 104, 6);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (12, 105, 2);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (17, 105, 3);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (5, 106, 4);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (18, 106, 5);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (21, 107, 3);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (11, 107, 4);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (4, 108, 6);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (9, 108, 3);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (10, 109, 5);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (2, 109, 7);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (23, 110, 2);
INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity) VALUES (13, 110, 3);

CREATE TABLE gpnr_promotion (
    promotion_id NUMBER(10) PRIMARY KEY,
    promotion_name VARCHAR2(255),
    start_date DATE,
    end_date DATE,
    promotion_discount NUMBER(3, 2)
);

-- gpnr_promotion
INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (1, 'Spring Sale', TO_DATE('2023-03-20', 'YYYY-MM-DD'), TO_DATE('2023-04-20', 'YYYY-MM-DD'), 0.15);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (2, 'Summer Clearance', TO_DATE('2023-06-21', 'YYYY-MM-DD'), TO_DATE('2023-07-21', 'YYYY-MM-DD'), 0.2);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (3, 'Back to School', TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-09-15', 'YYYY-MM-DD'), 0.1);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (4, 'Fall Fashion Event', TO_DATE('2023-09-22', 'YYYY-MM-DD'), TO_DATE('2023-10-22', 'YYYY-MM-DD'), 0.25);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (5, 'Black Friday', TO_DATE('2023-11-24', 'YYYY-MM-DD'), TO_DATE('2023-11-27', 'YYYY-MM-DD'), 0.3);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (6, 'Holiday Special', TO_DATE('2023-12-10', 'YYYY-MM-DD'), TO_DATE('2023-12-25', 'YYYY-MM-DD'), 0.2);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (7, 'New Year Clearance', TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-15', 'YYYY-MM-DD'), 0.25);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (8, 'Valentine''s Day Sale', TO_DATE('2024-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-14', 'YYYY-MM-DD'), 0.15);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (9, 'Spring Clearance', TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-15', 'YYYY-MM-DD'), 0.3);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (10, 'Easter Special', TO_DATE('2024-04-10', 'YYYY-MM-DD'), TO_DATE('2024-04-20', 'YYYY-MM-DD'), 0.2);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (11, 'Mother''s Day Sale', TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-10', 'YYYY-MM-DD'), 0.25);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, promotion_discount) 
VALUES (12, 'Memorial Day Weekend', TO_DATE('2024-05-25', 'YYYY-MM-DD'), TO_DATE('2024-05-28', 'YYYY-MM-DD'), 0.2);

CREATE TABLE gpnr_cart (
    cart_id NUMBER(10) PRIMARY KEY,
    cart_created_at TIMESTAMP,
    cart_status VARCHAR2(255),
    customer_username VARCHAR2(20),
    FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username)
);

CREATE TABLE gpnr_cart_product (
    cart_id NUMBER(10),
    product_id NUMBER(10),
    cart_product_quantity NUMBER(10),
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES gpnr_cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

-- gpnr_cart
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1001, TIMESTAMP '2023-05-10 08:00:00', 'active', 'jane_doe');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1002, TIMESTAMP '2023-06-15 08:15:00', 'active', 'john_smith');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1003, TIMESTAMP '2023-07-20 08:30:00', 'active', 'mike_jones');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1004, TIMESTAMP '2023-08-25 08:45:00', 'active', 'amy_wong');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1005, TIMESTAMP '2023-09-30 09:00:00', 'active', 'brian_smith');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1006, TIMESTAMP '2023-10-05 09:15:00', 'active', 'sarah_brown');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1007, TIMESTAMP '2023-11-10 09:30:00', 'active', 'david_kim');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1008, TIMESTAMP '2023-12-15 09:45:00', 'active', 'lisa_miller');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1009, TIMESTAMP '2024-01-20 10:00:00', 'active', 'kevin_lee');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1010, TIMESTAMP '2024-02-25 10:15:00', 'active', 'emily_taylor');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1011, TIMESTAMP '2024-03-30 10:30:00', 'active', 'jane_doe');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1012, TIMESTAMP '2024-04-05 10:45:00', 'active', 'john_smith');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1013, TIMESTAMP '2024-04-10 11:00:00', 'active', 'mike_jones');
INSERT INTO gpnr_cart (cart_id, cart_created_at, cart_status, customer_username) VALUES (1014, TIMESTAMP '2024-04-15 11:15:00', 'active', 'amy_wong');

-- gpnr_cart_product
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1001, 1, 3);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1001, 5, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1001, 8, 1);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1002, 3, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1002, 7, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1002, 11, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1002, 19, 3);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1003, 2, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1003, 10, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1003, 14, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1003, 16, 3);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1004, 6, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1004, 12, 1);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1005, 4, 3);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1005, 20, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1005, 23, 1);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1006, 15, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1006, 21, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1006, 22, 3);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1007, 13, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1007, 18, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1007, 25, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1007, 27, 2);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1008, 24, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1008, 26, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1008, 28, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1008, 29, 1);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1009, 9, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1009, 17, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1009, 30, 3);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1010, 2, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1010, 7, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1010, 13, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1010, 20, 1);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1011, 3, 3);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1011, 11, 2);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1012, 5, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1012, 16, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1012, 23, 3);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1013, 4, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1013, 9, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1013, 18, 2);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1013, 24, 1);

INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1014, 6, 3);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1014, 12, 1);
INSERT INTO gpnr_cart_product (cart_id, product_id, cart_product_quantity) VALUES (1014, 21, 2);

CREATE TABLE gpnr_payment_method (
    payment_method_id NUMBER(10) PRIMARY KEY,
    payment_name VARCHAR2(255),
    payment_method_discount NUMBER(3, 2)
);

CREATE TABLE gpnr_shipment (
    cart_id NUMBER(10) PRIMARY KEY,
    shipping_date DATE,
    shipping_address VARCHAR2(255),
    shipping_status VARCHAR2(255),
    total NUMBER(12, 2),
    shipper_username VARCHAR2(20),
    promotion_id NUMBER(10),
    district_id NUMBER(10),
    payment_method_id NUMBER(10),
    FOREIGN KEY (cart_id) REFERENCES gpnr_cart(cart_id),
    FOREIGN KEY (shipper_username) REFERENCES gpnr_shipper(shipper_username),
    FOREIGN KEY (promotion_id) REFERENCES gpnr_promotion(promotion_id),
    FOREIGN KEY (district_id) REFERENCES gpnr_district(district_id),
    FOREIGN KEY (payment_method_id) REFERENCES gpnr_payment_method(payment_method_id)
);
