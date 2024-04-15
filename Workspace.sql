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

CREATE TABLE gpnr_product_attribute (
    product_attribute_id NUMBER(10) PRIMARY KEY,
    product_attribute_name VARCHAR2(255),
    value VARCHAR2(255)
);

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

CREATE TABLE gpnr_category (
    category_id NUMBER(10) PRIMARY KEY,
    category_name VARCHAR2(255),
    category_description CLOB,
    parent_category_id NUMBER(10),
    CONSTRAINT fk_category_parent_category FOREIGN KEY (parent_category_id) REFERENCES gpnr_category(category_id)
);

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

CREATE SEQUENCE seq_gpnr_product_id START WITH 1 INCREMENT BY 1;

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
