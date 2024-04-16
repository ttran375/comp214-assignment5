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
    category_description CLOB
);

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
