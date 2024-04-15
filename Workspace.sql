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

CREATE TABLE gpnr_supplier (
    supplier_username VARCHAR2(20) PRIMARY KEY,
    supplier_password VARCHAR2(255),
    supplier_email VARCHAR2(255),
    supplier_firstname VARCHAR2(255),
    supplier_lastname VARCHAR2(255),
    supplier_phone VARCHAR2(15)
);

CREATE TABLE gpnr_product_attribute (
    product_attribute_id NUMBER(10) PRIMARY KEY,
    product_attribute_name VARCHAR2(255),
    value VARCHAR2(255)
);

CREATE TABLE gpnr_category (
    category_id NUMBER(10) PRIMARY KEY,
    category_name VARCHAR2(255),
    category_description CLOB,
    parent_category_id NUMBER(10),
    CONSTRAINT fk_category_parent_category FOREIGN KEY (parent_category_id) REFERENCES gpnr_category(category_id)
);

CREATE TABLE gpnr_product (
    product_id NUMBER(10) PRIMARY KEY,
    product_name VARCHAR2(255),
    product_description CLOB,
    price NUMBER(12, 2),
    product_quantity NUMBER(10),
    category_id NUMBER(10),
    product_attribute_id NUMBER(10),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES gpnr_category(category_id),
    CONSTRAINT fk_product_attribute FOREIGN KEY (product_attribute_id) REFERENCES gpnr_product_attribute(product_attribute_id)
);

CREATE TABLE gpnr_supplier_product (
    supplier_username VARCHAR2(20),
    product_id NUMBER(10),
    PRIMARY KEY (supplier_username, product_id),
    CONSTRAINT fk_supplier_product_supplier FOREIGN KEY (supplier_username) REFERENCES gpnr_supplier(supplier_username),
    CONSTRAINT fk_supplier_product_product FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

CREATE TABLE gpnr_customer (
    customer_username VARCHAR2(20) PRIMARY KEY,
    customer_password VARCHAR2(255),
    customer_email VARCHAR2(255),
    customer_firstname VARCHAR2(255),
    customer_lastname VARCHAR2(255),
    customer_phone VARCHAR2(15),
    customer_address VARCHAR2(255)
);

CREATE TABLE gpnr_promotion (
    promotion_id NUMBER(10) PRIMARY KEY,
    promotion_name VARCHAR2(255),
    start_date DATE,
    end_date DATE,
    discount NUMBER(5, 2)
);

CREATE TABLE gpnr_payment_info (
    payment_info_id NUMBER(10) PRIMARY KEY,
    card_number NUMBER(19),
    card_name VARCHAR2(255),
    card_expiration DATE,
    card_cvv VARCHAR2(4),
    customer_username VARCHAR2(20),
    CONSTRAINT fk_payment_info_customer FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username)
);

CREATE TABLE gpnr_request (
    request_id NUMBER(10) PRIMARY KEY,
    request_created_at TIMESTAMP,
    request_status VARCHAR2(255),
    request_cost NUMBER(12, 2),
    message CLOB,
    customer_username VARCHAR2(20),
    CONSTRAINT fk_request_customer FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username)
);

CREATE TABLE gpnr_product_request (
    product_id NUMBER(10),
    request_id NUMBER(10),
    product_request_quantity NUMBER(10),
    PRIMARY KEY (product_id, request_id),
    CONSTRAINT fk_product_request_request FOREIGN KEY (request_id) REFERENCES gpnr_request(request_id),
    CONSTRAINT fk_product_request_product FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

CREATE SEQUENCE seq_gpnr_product_id START WITH 1 INCREMENT BY 1;

-- gpnr_supplier
INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('johndoe', 'password123', 'johndoe@example.com', 'John', 'Doe', '123-456-7890');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('janedoe', 'pass123', 'janedoe@example.com', 'Jane', 'Doe', '456-789-0123');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('smithclothing', 'clothes123', 'info@smithclothing.com', 'Smith', 'Clothing', '789-012-3456');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('fashiontrends', 'fashionpass', 'contact@fashiontrends.com', 'Fashion', 'Trends', '012-345-6789');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('stylishthreads', 'stylish123', 'hello@stylishthreads.com', 'Stylish', 'Threads', '234-567-8901');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('sportychics', 'chicpass', 'support@sportychics.com', 'Sporty', 'Chics', '567-890-1234');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('trendyboutique', 'trendypass', 'info@trendyboutique.com', 'Trendy', 'Boutique', '890-123-4567');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('casualstyles', 'casualpass', 'hello@casualstyles.com', 'Casual', 'Styles', '901-234-5678');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('elegantwear', 'elegant123', 'info@elegantwear.com', 'Elegant', 'Wear', '345-678-9012');

INSERT INTO gpnr_supplier (supplier_username, supplier_password, supplier_email, supplier_firstname, supplier_lastname, supplier_phone)
VALUES ('vintagevibes', 'vintagepass', 'contact@vintagevibes.com', 'Vintage', 'Vibes', '678-901-2345');

-- gpnr_product_attribute
INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (1, 'Color', 'Red');

INSERT INTO gpnr_product_attribute (product_attribute_id, product_attribute_name, value)
VALUES (2, 'Color', 'Blue');

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

-- gpnr_category
INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (1, 'Tops', 'Collection of upper clothing items', NULL);

INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (2, 'Bottoms', 'Collection of lower clothing items', NULL);

INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (3, 'Shirts', 'Variety of shirts for men and women', 1);

INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (4, 'Pants', 'Different styles and types of pants', 2);

INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (5, 'Dresses', 'Assorted styles and lengths of dresses', 1);

INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (6, 'Skirts', 'Various skirt designs for women', 2);

INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (7, 'Trousers', 'Different styles of trousers for men and women', 2);

INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (8, 'Outerwear', 'Jackets, coats, and other outer clothing items', NULL);

INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (9, 'Activewear', 'Sportswear and athletic clothing', NULL);

INSERT INTO gpnr_category (category_id, category_name, category_description, parent_category_id)
VALUES (10, 'Accessories', 'Various fashion accessories such as belts, scarves, and hats', NULL);

-- gpnr_product
INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Red Cotton T-Shirt', 'Comfortable red cotton t-shirt for everyday wear', 19.99, 100, 3, 1);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Blue Denim Jeans', 'Classic blue denim jeans for a timeless look', 29.99, 75, 4, 14);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Green Silk Blouse', 'Elegant green silk blouse for formal occasions', 39.99, 50, 3, 13);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Yellow Polyester Hoodie', 'Bright yellow polyester hoodie for a pop of color', 49.99, 80, 1, 12);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Black Spandex Leggings', 'Versatile black spandex leggings for workouts or casual wear', 24.99, 120, 4, 15);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'White Cotton Dress Shirt', 'Classic white cotton dress shirt for a professional look', 34.99, 90, 3, 1);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Gray Polyester Joggers', 'Comfortable gray polyester joggers for lounging', 27.99, 60, 7, 12);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Small Red Scarf', 'Soft small red scarf to accessorize any outfit', 14.99, 150, 10, 1);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Medium Blue Belt', 'Stylish medium blue belt to cinch your waist', 9.99, 200, 10, 2);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Large Green Hat', 'Fashionable large green hat for sun protection', 19.99, 100, 10, 3);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Red Cotton Polo Shirt', 'Classic red cotton polo shirt for a sporty look', 29.99, 80, 3, 1);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Blue Polyester Jacket', 'Stylish blue polyester jacket for chilly days', 59.99, 70, 8, 12);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Green Silk Maxi Dress', 'Elegant green silk maxi dress for special occasions', 79.99, 40, 5, 13);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Yellow Denim Shorts', 'Casual yellow denim shorts for summer days', 24.99, 100, 6, 14);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Black Spandex Yoga Pants', 'Stretchy black spandex yoga pants for exercise', 34.99, 90, 7, 15);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'White Cotton Blouse', 'Versatile white cotton blouse for any occasion', 39.99, 60, 3, 1);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Gray Polyester Tracksuit', 'Comfortable gray polyester tracksuit for workouts', 54.99, 50, 9, 12);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Small Red Leather Belt', 'Chic small red leather belt to accentuate your waist', 29.99, 80, 10, 1);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Medium Blue Silk Scarf', 'Luxurious medium blue silk scarf for a touch of elegance', 44.99, 60, 10, 2);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Large Green Sun Hat', 'Stylish large green sun hat for sunny days', 19.99, 100, 10, 3);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Red Cotton Hoodie', 'Classic red cotton hoodie for casual comfort', 34.99, 70, 1, 1);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Blue Polyester Raincoat', 'Waterproof blue polyester raincoat for rainy days', 69.99, 40, 8, 12);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Green Silk Cocktail Dress', 'Stunning green silk cocktail dress for parties', 89.99, 30, 5, 13);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Yellow Denim Skirt', 'Casual yellow denim skirt for a trendy look', 39.99, 60, 6, 14);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Black Spandex Leggings', 'Versatile black spandex leggings for workouts or casual wear', 24.99, 120, 4, 15);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'White Cotton T-Shirt', 'Basic white cotton t-shirt for everyday wear', 14.99, 150, 3, 1);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Gray Polyester Joggers', 'Comfortable gray polyester joggers for lounging', 27.99, 60, 7, 12);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Small Red Scarf', 'Soft small red scarf to accessorize any outfit', 14.99, 150, 10, 1);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Medium Blue Belt', 'Stylish medium blue belt to cinch your waist', 9.99, 200, 10, 2);

INSERT INTO gpnr_product (product_id, product_name, product_description, price, product_quantity, category_id, product_attribute_id) 
VALUES (seq_gpnr_product_id.NEXTVAL, 'Large Green Hat', 'Fashionable large green hat for sun protection', 19.99, 100, 10, 3);

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

-- gpnr_customer
INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('john_doe', 'password123', 'john@example.com', 'John', 'Doe', '123-456-7890', '123 Main St, Cityville');

INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('jane_smith', 'p@ssw0rd', 'jane@example.com', 'Jane', 'Smith', '234-567-8901', '456 Elm St, Townsville');

INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('mike_jones', 'securepass', 'mike@example.com', 'Mike', 'Jones', '345-678-9012', '789 Oak St, Villageton');

INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('amy_wong', 'password123', 'amy@example.com', 'Amy', 'Wong', '456-789-0123', '101 Pine St, Hamletville');

INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('brian_smith', 'brianspassword', 'brian@example.com', 'Brian', 'Smith', '567-890-1234', '246 Maple St, Suburbia');

INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('sarah_brown', 'sarahpass', 'sarah@example.com', 'Sarah', 'Brown', '678-901-2345', '369 Cedar St, Countryside');

INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('david_kim', 'david123', 'david@example.com', 'David', 'Kim', '789-012-3456', '753 Walnut St, Metropolis');

INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('lisa_miller', 'lisapassword', 'lisa@example.com', 'Lisa', 'Miller', '890-123-4567', '852 Birch St, Downtown');

INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('kevin_lee', 'kevinpass', 'kevin@example.com', 'Kevin', 'Lee', '901-234-5678', '963 Sycamore St, Uptown');

INSERT INTO gpnr_customer (customer_username, customer_password, customer_email, customer_firstname, customer_lastname, customer_phone, customer_address) 
VALUES ('emily_taylor', 'emilypass', 'emily@example.com', 'Emily', 'Taylor', '012-345-6789', '147 Cherry St, Midtown');

-- gpnr_promotion
INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (1, 'Spring Sale', TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), 0.15);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (2, 'Summer Clearance', TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 0.25);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (3, 'Back to School', TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-09-15', 'YYYY-MM-DD'), 0.20);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (4, 'Fall Fashion', TO_DATE('2024-09-15', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'), 0.10);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (5, 'Winter Warm-Up', TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), 0.30);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (6, 'Holiday Sale', TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-25', 'YYYY-MM-DD'), 0.25);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (7, 'New Year Clearance', TO_DATE('2024-12-26', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'), 0.40);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (8, 'Valentine''s Day Special', TO_DATE('2025-02-01', 'YYYY-MM-DD'), TO_DATE('2025-02-14', 'YYYY-MM-DD'), 0.15);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (9, 'Spring Preview', TO_DATE('2025-02-15', 'YYYY-MM-DD'), TO_DATE('2025-02-28', 'YYYY-MM-DD'), 0.10);

INSERT INTO gpnr_promotion (promotion_id, promotion_name, start_date, end_date, discount)
VALUES (10, 'Early Summer Sale', TO_DATE('2025-05-01', 'YYYY-MM-DD'), TO_DATE('2025-05-31', 'YYYY-MM-DD'), 0.20);

-- gpnr_payment_info
INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (1, 1234567890123456, 'John Doe', TO_DATE('2026-12-31', 'YYYY-MM-DD'), '123', 'john_doe');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (2, 2345678901234567, 'Jane Smith', TO_DATE('2027-06-30', 'YYYY-MM-DD'), '234', 'jane_smith');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (3, 3456789012345678, 'Mike Jones', TO_DATE('2025-09-30', 'YYYY-MM-DD'), '345', 'mike_jones');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (4, 4567890123456789, 'Michael Jones', TO_DATE('2028-03-31', 'YYYY-MM-DD'), '456', 'mike_jones');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (5, 5678901234567890, 'Amy Wong', TO_DATE('2024-12-31', 'YYYY-MM-DD'), '567', 'amy_wong');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (6, 6789012345678901, 'Brian Smith', TO_DATE('2026-11-30', 'YYYY-MM-DD'), '678', 'brian_smith');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (7, 7890123456789012, 'Sarah Brown', TO_DATE('2025-10-31', 'YYYY-MM-DD'), '789', 'sarah_brown');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (8, 8901234567890123, 'David Kim', TO_DATE('2027-08-31', 'YYYY-MM-DD'), '890', 'david_kim');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (9, 9012345678901234, 'Lisa Miller', TO_DATE('2024-09-30', 'YYYY-MM-DD'), '901', 'lisa_miller');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (10, 1234567890123456, 'Kevin Lee', TO_DATE('2028-07-31', 'YYYY-MM-DD'), '012', 'kevin_lee');

INSERT INTO gpnr_payment_info (payment_info_id, card_number, card_name, card_expiration, card_cvv, customer_username)
VALUES (11, 2345678901234567, 'Emily Taylor', TO_DATE('2025-04-30', 'YYYY-MM-DD'), '123', 'emily_taylor');

INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username)
VALUES (101, SYSTIMESTAMP, 'Pending', 0, 'Please process this order as soon as possible.', 'john_doe');

INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username)
VALUES (102, SYSTIMESTAMP, 'Pending', 0, 'I need these items urgently.', 'jane_smith');

INSERT INTO gpnr_request (request_id, request_created_at, request_status, request_cost, message, customer_username)
VALUES (103, SYSTIMESTAMP, 'Pending', 0, 'Can you expedite the delivery?', 'mike_jones');

INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity)
VALUES (1, 101, 2);

INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity)
VALUES (5, 101, 1);

INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity)
VALUES (1, 102, 1);

INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity)
VALUES (12, 102, 3);

INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity)
VALUES (3, 103, 2);

INSERT INTO gpnr_product_request (product_id, request_id, product_request_quantity)
VALUES (14, 103, 2);

CREATE TABLE gpnr_customer_promotion (
    customer_username VARCHAR2(20),
    promotion_id NUMBER(10),
    PRIMARY KEY (customer_username, promotion_id),
    CONSTRAINT fk_cust_prom_customer FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username),
    CONSTRAINT fk_cust_prom_promotion FOREIGN KEY (promotion_id) REFERENCES gpnr_promotion(promotion_id)
);

CREATE TABLE gpnr_cart (
    cart_id NUMBER(10) PRIMARY KEY,
    cart_created_at TIMESTAMP,
    cart_status VARCHAR2(255),
    cart_discount NUMBER(5, 2),
    total NUMBER(12, 2),
    shipping_id NUMBER(10),
    customer_username VARCHAR2(20),
    CONSTRAINT fk_cart_shipping FOREIGN KEY (shipping_id) REFERENCES gpnr_shipping(shipping_id),
    CONSTRAINT fk_cart_customer FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username)
);

CREATE TABLE gpnr_product_cart (
    product_id NUMBER(10),
    cart_id NUMBER(10),
    product_cart_quantity NUMBER(10),
    PRIMARY KEY (product_id, cart_id),
    CONSTRAINT fk_product_cart_cart FOREIGN KEY (cart_id) REFERENCES gpnr_cart(cart_id),
    CONSTRAINT fk_product_cart_product FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

CREATE TABLE gpnr_shipping (
    shipping_id NUMBER(10) PRIMARY KEY,
    shipping_date TIMESTAMP,
    shipping_address VARCHAR2(255),
    shipping_state VARCHAR2(255),
    shipping_status VARCHAR2(255),
    shipping_cost NUMBER(12, 2),
    shipping_rating NUMBER(5, 2),
    shipper_username VARCHAR2(20),
    CONSTRAINT fk_shipping_shipper FOREIGN KEY (shipper_username) REFERENCES gpnr_shipper(shipper_username)
);

CREATE TABLE gpnr_shipper (
    shipper_username VARCHAR2(20) PRIMARY KEY,
    shipper_password VARCHAR2(255),
    shipper_email VARCHAR2(255),
    shipper_firstname VARCHAR2(255),
    shipper_lastname VARCHAR2(255),
    shipper_phone VARCHAR2(15),
    shipper_rating NUMBER(5, 2)
);
