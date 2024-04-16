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
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('janedoe', 2);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('smithclothing', 3);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('fashiontrends', 4);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('stylishthreads', 5);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('sportychics', 6);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('trendyboutique', 7);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('casualstyles', 8);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('elegantwear', 9);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('vintagevibes', 10);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('johndoe', 11);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('janedoe', 12);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('smithclothing', 13);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('fashiontrends', 14);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('stylishthreads', 15);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('sportychics', 16);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('trendyboutique', 17);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('casualstyles', 18);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('elegantwear', 19);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('vintagevibes', 20);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('johndoe', 21);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('janedoe', 22);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('smithclothing', 23);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('fashiontrends', 24);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('stylishthreads', 25);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('sportychics', 26);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('trendyboutique', 27);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('casualstyles', 28);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('elegantwear', 29);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('vintagevibes', 30);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('johndoe', 1);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('janedoe', 2);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('smithclothing', 3);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('fashiontrends', 4);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('stylishthreads', 5);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('sportychics', 6);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('trendyboutique', 7);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('casualstyles', 8);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('elegantwear', 9);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('vintagevibes', 10);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('johndoe', 11);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('janedoe', 12);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('smithclothing', 13);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('fashiontrends', 14);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('stylishthreads', 15);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('sportychics', 16);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('trendyboutique', 17);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('casualstyles', 18);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('elegantwear', 19);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('vintagevibes', 20);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('johndoe', 21);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('janedoe', 22);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('smithclothing', 23);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('fashiontrends', 24);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('stylishthreads', 25);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('sportychics', 26);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('trendyboutique', 27);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('casualstyles', 28);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('elegantwear', 29);
INSERT INTO gpnr_supplier_product (supplier_username, product_id) VALUES ('vintagevibes', 30);
