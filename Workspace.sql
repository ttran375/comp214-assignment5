DECLARE
    lv_sql VARCHAR2(1000);
BEGIN
    -- Drop all tables
    FOR tab IN (
        SELECT
            table_name
        FROM
            user_tables
    ) LOOP
        lv_sql := 'DROP TABLE '
                 || tab.table_name
                 || ' CASCADE CONSTRAINTS';
        EXECUTE IMMEDIATE lv_sql;
    END LOOP;
    -- Drop all sequences
    FOR seq IN (
        SELECT
            sequence_name
        FROM
            user_sequences
    ) LOOP
        lv_sql := 'DROP SEQUENCE '
                 || seq.sequence_name;
        EXECUTE IMMEDIATE lv_sql;
    END LOOP;
    -- Drop all procedures
    FOR proc IN (
        SELECT
            object_name
        FROM
            user_objects
        WHERE
            object_type = 'PROCEDURE'
    ) LOOP
        lv_sql := 'DROP PROCEDURE '
                 || proc.object_name;
        EXECUTE IMMEDIATE lv_sql;
    END LOOP;
    -- Drop all functions
    FOR func IN (
        SELECT
            object_name
        FROM
            user_objects
        WHERE
            object_type = 'FUNCTION'
    ) LOOP
        lv_sql := 'DROP FUNCTION '
                 || func.object_name;
        EXECUTE IMMEDIATE lv_sql;
    END LOOP;
    -- Drop all indexes
    FOR idx IN (
        SELECT
            index_name
        FROM
            user_indexes
    ) LOOP
        lv_sql := 'DROP INDEX '
                 || idx.index_name;
        EXECUTE IMMEDIATE lv_sql;
    END LOOP;
 -- Drop all triggers
    FOR trig IN (
        SELECT
            trigger_name
        FROM
            user_triggers
    ) LOOP
        lv_sql := 'DROP TRIGGER '
                 || trig.trigger_name;
        EXECUTE IMMEDIATE lv_sql;
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
    category_description CLOB
);

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

CREATE TABLE gpnr_product_supplier (
    supplier_username VARCHAR2(20),
    product_id NUMBER(10),
    PRIMARY KEY (supplier_username, product_id),
    FOREIGN KEY (supplier_username) REFERENCES gpnr_supplier(supplier_username),
    FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

CREATE TABLE gpnr_district (
    district_id NUMBER(10) PRIMARY KEY,
    district VARCHAR2(20),
    tax NUMBER(3, 2),
    shipping_cost NUMBER(3, 2)
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

CREATE TABLE gpnr_promotion (
    promotion_id NUMBER(10) PRIMARY KEY,
    promotion_name VARCHAR2(255),
    start_date DATE,
    end_date DATE,
    promotion_discount NUMBER(3, 2)
);

CREATE TABLE gpnr_cart (
    cart_id NUMBER(10) PRIMARY KEY,
    cart_created_at TIMESTAMP,
    cart_status VARCHAR2(255) DEFAULT 'pending',
    customer_username VARCHAR2(20),
    FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username)
);

CREATE TABLE gpnr_product_cart (
    cart_id NUMBER(10),
    product_id NUMBER(10),
    cart_product_quantity NUMBER(10),
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES gpnr_cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

CREATE TABLE gpnr_payment_method (
    payment_method_id NUMBER(10) PRIMARY KEY,
    payment_name VARCHAR2(255),
    payment_method_discount NUMBER(3, 2)
);

CREATE TABLE gpnr_shipment (
    cart_id NUMBER(10) PRIMARY KEY,
    shipping_date DATE,
    shipping_status VARCHAR2(20) DEFAULT 'Pending',
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

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'justin_doe',
    'justin.doe@example.com',
    'Justin',
    'Doe',
    '1234567890'
);

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'walter_smith',
    'walter.smith@example.com',
    'Walter',
    'Smith',
    '1987654321'
);

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'mike_jones',
    'mike.jones@example.com',
    'Mike',
    'Jones',
    '1122334455'
);

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'emily_brown',
    'emily.brown@example.com',
    'Emily',
    'Brown',
    '1567890123'
);

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'alex_wilson',
    'alex.wilson@example.com',
    'Alex',
    'Wilson',
    '1432987654'
);

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'susan_jackson',
    'susan.jackson@example.com',
    'Susan',
    'Jackson',
    '1876543210'
);

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'david_miller',
    'david.miller@example.com',
    'David',
    'Miller',
    '1789054321'
);

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'lisa_taylor',
    'lisa.taylor@example.com',
    'Lisa',
    'Taylor',
    '1908765432'
);

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'chris_anderson',
    'chris.anderson@example.com',
    'Chris',
    'Anderson',
    '1654321890'
);

INSERT INTO gpnr_shipper (
    shipper_username,
    shipper_email,
    shipper_firstname,
    shipper_lastname,
    shipper_phone
) VALUES (
    'sophia_thomas',
    'sophia.thomas@example.com',
    'Sophia',
    'Thomas',
    '1432765432'
);

-- Trigger to ensure the supplier_username is unique
CREATE OR REPLACE TRIGGER check_supplier_username BEFORE
    INSERT OR UPDATE ON gpnr_supplier FOR EACH ROW
DECLARE
    -- Declare a variable to hold the count of existing usernames
    lv_username_exists NUMBER;
BEGIN
    -- Check if the new username already exists in the gpnr_supplier table
    SELECT
        COUNT(*) INTO lv_username_exists
    FROM
        gpnr_supplier
    WHERE
        supplier_username = :NEW.supplier_username;
    -- If the count is greater than 0, it means the username already exists, so raise an error
    IF lv_username_exists > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Supplier username already exists');
    END IF;
END;
/

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'johndoe',
    'password123',
    'johndoe@example.com',
    'John',
    'Doe',
    '1234567890'
);

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'janedoe',
    'pass123',
    'janedoe@example.com',
    'Jane',
    'Doe',
    '4567890123'
);

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'smithclothing',
    'clothes123',
    'info@smithclothing.com',
    'Smith',
    'Clothing',
    '7890123456'
);

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'fashiontrends',
    'fashionpass',
    'contact@fashiontrends.com',
    'Fashion',
    'Trends',
    '0123456789'
);

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'stylishthreads',
    'stylish123',
    'hello@stylishthreads.com',
    'Stylish',
    'Threads',
    '2345678901'
);

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'sportychics',
    'chicpass',
    'support@sportychics.com',
    'Sporty',
    'Chics',
    '5678901234'
);

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'trendyboutique',
    'trendypass',
    'info@trendyboutique.com',
    'Trendy',
    'Boutique',
    '8901234567'
);

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'casualstyles',
    'casualpass',
    'hello@casualstyles.com',
    'Casual',
    'Styles',
    '9012345678'
);

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'elegantwear',
    'elegant123',
    'info@elegantwear.com',
    'Elegant',
    'Wear',
    '3456789012'
);

INSERT INTO gpnr_supplier (
    supplier_username,
    supplier_password,
    supplier_email,
    supplier_firstname,
    supplier_lastname,
    supplier_phone
) VALUES (
    'vintagevibes',
    'vintagepass',
    'contact@vintagevibes.com',
    'Vintage',
    'Vibes',
    '6789012345'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    1,
    'Color',
    'Red'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    2,
    'Color',
    'Navy Blue'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    3,
    'Color',
    'Green'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    4,
    'Color',
    'Yellow'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    5,
    'Color',
    'Black'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    6,
    'Color',
    'White'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    7,
    'Color',
    'Gray'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    8,
    'Size',
    'Small'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    9,
    'Size',
    'Medium'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    10,
    'Size',
    'Large'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    11,
    'Material',
    'Cotton'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    12,
    'Material',
    'Polyester'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    13,
    'Material',
    'Silk'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    14,
    'Material',
    'Denim'
);

INSERT INTO gpnr_product_attribute (
    product_attribute_id,
    product_attribute_name,
    value
) VALUES (
    15,
    'Material',
    'Spandex'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    1,
    'Clothing',
    'A wide range of fashionable clothing items for all occasions.'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    2,
    'Footwear',
    'Stylish and comfortable footwear for men, women, and children.'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    3,
    'Accessories',
    'Trendy accessories to complement your outfits and add flair to your look.'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    4,
    'Sportswear',
    'High-quality sportswear designed for performance and style.'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    5,
    'Formal Wear',
    'Elegant attire suitable for formal events and special occasions.'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    6,
    'Casual Wear',
    'Comfortable and chic clothing for everyday wear.'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    7,
    'Vintage Fashion',
    'Unique and timeless fashion pieces inspired by the past decades.'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    8,
    'Swimwear',
    'Fashionable swimwear for lounging by the pool or hitting the beach in style.'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    9,
    'Outerwear',
    'Stylish outerwear options to keep you warm and fashionable in any weather.'
);

INSERT INTO gpnr_category (
    category_id,
    category_name,
    category_description
) VALUES (
    10,
    'Loungewear',
    'Comfortable and trendy loungewear perfect for relaxing at home or running errands.'
);

-- Procedure to ensure that both the category ID and attribute ID are valid
CREATE OR REPLACE PROCEDURE add_new_product (
    p_product_id IN NUMBER,
    p_product_name IN VARCHAR2,
    p_price IN NUMBER,
    p_quantity IN NUMBER,
    p_category_id IN NUMBER,
    p_attribute_id IN NUMBER
) AS
    lv_category_count  NUMBER;
    lv_attribute_count NUMBER;
BEGIN
    -- Check if the given category ID exists in the category table
    SELECT
        COUNT(*) INTO lv_category_count
    FROM
        gpnr_category
    WHERE
        category_id = p_category_id;
    -- If category ID does not exist, raise an error
    IF lv_category_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Category ID does not exist.');
    END IF;
    -- Check if the given attribute ID exists in the product attribute table
    SELECT
        COUNT(*) INTO lv_attribute_count
    FROM
        gpnr_product_attribute
    WHERE
        product_attribute_id = p_attribute_id;
    -- If attribute ID does not exist, raise an error
    IF lv_attribute_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Product Attribute ID does not exist.');
    END IF;
    -- Insert the new product into the product table
    INSERT INTO gpnr_product (
        product_id,
        product_name,
        price,
        product_quantity,
        category_id,
        product_attribute_id
    ) VALUES (
        p_product_id,
        p_product_name,
        p_price,
        p_quantity,
        p_category_id,
        p_attribute_id
    );
    -- Commit the transaction
    COMMIT;
EXCEPTION
    -- Rollback changes if any error occurs and re-raise the exception
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

BEGIN
    add_new_product(1, 'Red T-Shirt', 19.99, 100, 1, 1);
    add_new_product(2, 'Navy Blue Jeans', 29.99, 75, 1, 14);
    add_new_product(3, 'Green Dress', 39.99, 50, 5, 6);
    add_new_product(4, 'Yellow Hoodie', 34.99, 80, 6, 1);
    add_new_product(5, 'Black Leggings', 24.99, 90, 1, 15);
    add_new_product(6, 'White Sneakers', 49.99, 60, 2, 6);
    add_new_product(7, 'Gray Sweatpants', 29.99, 70, 6, 7);
    add_new_product(8, 'Small Red Backpack', 39.99, 40, 3, 1);
    add_new_product(9, 'Navy Blue Socks', 7.29, 30, 9, 2);
    add_new_product(10, 'Large Green Scarf', 19.99, 50, 3, 6);
    add_new_product(11, 'Black Swimsuit', 29.99, 45, 8, 15);
    add_new_product(12, 'White Sunglasses', 14.99, 100, 3, 6);
    add_new_product(13, 'Gray Hat', 9.99, 120, 3, 7);
    add_new_product(14, 'Small Black Gym Bag', 24.99, 80, 4, 5);
    add_new_product(15, 'Medium Navy Blue Yoga Mat', 29.99, 60, 4, 2);
    add_new_product(16, 'Large Green Water Bottle', 19.99, 70, 4, 4);
    add_new_product(17, 'Red Soccer Jersey', 39.99, 40, 4, 1);
    add_new_product(18, 'Navy Blue Basketball Shorts', 24.99, 50, 4, 14);
    add_new_product(19, 'Green Running Shoes', 59.99, 30, 4, 6);
    add_new_product(20, 'Yellow Tennis Skirt', 34.99, 35, 4, 15);
    add_new_product(21, 'Black Baseball Cap', 19.99, 80, 3, 5);
    add_new_product(22, 'White Leather Belt', 29.99, 60, 3, 6);
    add_new_product(23, 'Gray Wool Gloves', 14.99, 100, 3, 7);
    add_new_product(24, 'Small Red Handbag', 39.99, 40, 3, 1);
    add_new_product(25, 'Medium Navy Blue Necktie', 24.99, 50, 5, 14);
    add_new_product(26, 'Large Green Suit', 59.99, 30, 5, 6);
    add_new_product(27, 'Black Dress Shoes', 49.99, 35, 2, 5);
    add_new_product(28, 'White Lace Gloves', 19.99, 70, 5, 6);
    add_new_product(29, 'Gray Bow Tie', 14.99, 100, 5, 7);
    add_new_product(30, 'Small Red Suspenders', 24.99, 80, 5, 1);
END;
/

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'johndoe',
    1
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'johndoe',
    6
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'johndoe',
    17
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'janedoe',
    3
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'janedoe',
    12
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'janedoe',
    25
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'smithclothing',
    2
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'smithclothing',
    7
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'smithclothing',
    20
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'fashiontrends',
    5
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'fashiontrends',
    13
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'fashiontrends',
    26
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'stylishthreads',
    4
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'stylishthreads',
    11
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'stylishthreads',
    24
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'sportychics',
    10
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'sportychics',
    16
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'sportychics',
    29
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'trendyboutique',
    8
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'trendyboutique',
    14
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'trendyboutique',
    27
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'casualstyles',
    9
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'casualstyles',
    15
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'casualstyles',
    28
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'elegantwear',
    16
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'elegantwear',
    22
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'elegantwear',
    30
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'vintagevibes',
    10
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'vintagevibes',
    18
);

INSERT INTO gpnr_product_supplier (
    supplier_username,
    product_id
) VALUES (
    'vintagevibes',
    23
);

INSERT INTO gpnr_district (
    district_id,
    district,
    tax,
    shipping_cost
) VALUES (
    1,
    'Toronto Central',
    0.15,
    0.10
);

INSERT INTO gpnr_district (
    district_id,
    district,
    tax,
    shipping_cost
) VALUES (
    2,
    'North York',
    0.12,
    0.05
);

INSERT INTO gpnr_district (
    district_id,
    district,
    tax,
    shipping_cost
) VALUES (
    3,
    'Scarborough',
    0.18,
    0.08
);

INSERT INTO gpnr_district (
    district_id,
    district,
    tax,
    shipping_cost
) VALUES (
    4,
    'Etobicoke',
    0.10,
    0.07
);

INSERT INTO gpnr_district (
    district_id,
    district,
    tax,
    shipping_cost
) VALUES (
    5,
    'East York',
    0.17,
    0.06
);

INSERT INTO gpnr_district (
    district_id,
    district,
    tax,
    shipping_cost
) VALUES (
    6,
    'York',
    0.20,
    0.09
);

INSERT INTO gpnr_district (
    district_id,
    district,
    tax,
    shipping_cost
) VALUES (
    7,
    'Mississauga',
    0.13,
    0.11
);

INSERT INTO gpnr_district (
    district_id,
    district,
    tax,
    shipping_cost
) VALUES (
    8,
    'Toronto West',
    0.16,
    0.12
);

-- Trigger to prevent duplicate customer_username values
CREATE OR REPLACE TRIGGER check_username BEFORE
    INSERT OR UPDATE ON gpnr_customer FOR EACH ROW
DECLARE
    -- Declare a variable to hold the count of existing usernames
    lv_username_exists NUMBER;
BEGIN
    -- Check if the new username already exists in the gpnr_customer table
    SELECT
        COUNT(*) INTO lv_username_exists
    FROM
        gpnr_customer
    WHERE
        customer_username = :NEW.customer_username;
    -- If the count is greater than 0, it means the username already exists, so raise an error
    IF lv_username_exists > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Username already exists');
    END IF;
END;
/

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'jane_doe',
    'password1231',
    'jane_doe@example.com',
    'John',
    'Doe',
    '1234567890',
    '123 Main St, Toronto Central'
);

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'john_smith',
    'p@ssw0rd2',
    'john_smith@example.com',
    'Jane',
    'Smith',
    '2345678901',
    '456 Elm St, North York'
);

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'mike_jones',
    'securepass3',
    'mike_jones@example.com',
    'Mike',
    'Johnson',
    '3456789012',
    '789 Maple Ave, York'
);

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'amy_wong',
    'password1234',
    'amy_wong@example.com',
    'Emily',
    'Brown',
    '4567890123',
    '987 Oak St, Etobicoke'
);

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'brian_smith',
    'brianspassword5',
    'brian_smith@example.com',
    'Chris',
    'Lee',
    '5678901234',
    '654 Pine St, East York'
);

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'sarah_brown',
    'sarahpass6',
    'sarah_brown@example.com',
    'Sarah',
    'Taylor',
    '6789012345',
    '321 Cedar St, Scarborough'
);

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'david_kim',
    'david1237',
    'david_kim@example.com',
    'David',
    'Clark',
    '7890123456',
    '987 Walnut St, Mississauga'
);

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'lisa_miller',
    'lisapassword8',
    'lisa_miller@example.com',
    'Amanda',
    'Martinez',
    '8901234567',
    '654 Birch St, Toronto West'
);

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'kevin_lee',
    'kevinpass9',
    'kevin_lee@example.com',
    'Michael',
    'Garcia',
    '9012345678',
    '321 Spruce St, Scarborough'
);

INSERT INTO gpnr_customer (
    customer_username,
    customer_password,
    customer_email,
    customer_firstname,
    customer_lastname,
    customer_phone,
    customer_address
) VALUES (
    'emily_taylor',
    'emilypass',
    'emily_taylor@example.com',
    'Jessica',
    'Lopez',
    '0123456789',
    '789 Oak St, East York'
);

CREATE SEQUENCE seq_gpnr_request_id START WITH 101 INCREMENT BY 1;

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2023-06-16 10:00:00',
    'Pending',
    0.1,
    'Please process this request as soon as possible.',
    'jane_doe'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    7,
    seq_gpnr_request_id.CURRVAL,
    5
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    8,
    seq_gpnr_request_id.CURRVAL,
    3
);

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2023-07-05 11:30:00',
    'Approved',
    0.2,
    'Urgent request. Need immediate attention.',
    'john_smith'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    7,
    seq_gpnr_request_id.CURRVAL,
    2
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    6,
    seq_gpnr_request_id.CURRVAL,
    4
);

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2023-08-20 13:45:00',
    'Pending',
    0.3,
    'This is a test message for the request.',
    'mike_jones'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    20,
    seq_gpnr_request_id.CURRVAL,
    7
);

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2023-09-10 15:20:00',
    'Rejected',
    0.05,
    'Request has been rejected due to insufficient funds.',
    'amy_wong'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    7,
    seq_gpnr_request_id.CURRVAL,
    6
);

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2023-10-05 08:45:00',
    'Approved',
    0.1,
    'Request approved. Processing will begin shortly.',
    'brian_smith'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    12,
    seq_gpnr_request_id.CURRVAL,
    2
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    17,
    seq_gpnr_request_id.CURRVAL,
    3
);

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2023-11-25 11:30:00',
    'Pending',
    0.15,
    'Please expedite processing for this request.',
    'sarah_brown'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    5,
    seq_gpnr_request_id.CURRVAL,
    4
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    18,
    seq_gpnr_request_id.CURRVAL,
    5
);

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2023-12-10 14:15:00',
    'Approved',
    0.2,
    'Request approved. Payment has been processed.',
    'david_kim'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    21,
    seq_gpnr_request_id.CURRVAL,
    3
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    11,
    seq_gpnr_request_id.CURRVAL,
    4
);

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2024-01-05 09:00:00',
    'Pending',
    0.25,
    'Request is urgent. Please prioritize processing.',
    'lisa_miller'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    4,
    seq_gpnr_request_id.CURRVAL,
    6
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    9,
    seq_gpnr_request_id.CURRVAL,
    3
);

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2024-02-15 13:30:00',
    'Rejected',
    0.3,
    'Request rejected due to incomplete information.',
    'kevin_lee'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    10,
    seq_gpnr_request_id.CURRVAL,
    5
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    2,
    seq_gpnr_request_id.CURRVAL,
    7
);

INSERT INTO gpnr_request (
    request_id,
    request_created_at,
    request_status,
    request_cost,
    message,
    customer_username
) VALUES (
    seq_gpnr_request_id.NEXTVAL,
    TIMESTAMP '2024-03-20 17:45:00',
    'Pending',
    0.05,
    'Please process this request at the earliest convenience.',
    'emily_taylor'
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    23,
    seq_gpnr_request_id.CURRVAL,
    2
);

INSERT INTO gpnr_product_request (
    product_id,
    request_id,
    product_request_quantity
) VALUES (
    13,
    seq_gpnr_request_id.CURRVAL,
    3
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    1,
    'Spring Sale',
    TO_DATE('2023-03-20', 'YYYY-MM-DD'),
    TO_DATE('2023-04-20', 'YYYY-MM-DD'),
    0.15
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    2,
    'Summer Clearance',
    TO_DATE('2023-05-01', 'YYYY-MM-DD'),
    TO_DATE('2023-07-21', 'YYYY-MM-DD'),
    0.2
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    3,
    'Back to School',
    TO_DATE('2023-08-15', 'YYYY-MM-DD'),
    TO_DATE('2023-09-15', 'YYYY-MM-DD'),
    0.1
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    4,
    'Fall Fashion Event',
    TO_DATE('2023-09-22', 'YYYY-MM-DD'),
    TO_DATE('2023-10-22', 'YYYY-MM-DD'),
    0.25
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    5,
    'Black Friday',
    TO_DATE('2023-11-24', 'YYYY-MM-DD'),
    TO_DATE('2023-11-27', 'YYYY-MM-DD'),
    0.3
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    6,
    'Holiday Special',
    TO_DATE('2023-12-10', 'YYYY-MM-DD'),
    TO_DATE('2023-12-25', 'YYYY-MM-DD'),
    0.2
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    7,
    'New Year Clearance',
    TO_DATE('2024-01-01', 'YYYY-MM-DD'),
    TO_DATE('2024-01-15', 'YYYY-MM-DD'),
    0.25
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    8,
    'Valentine''s Day Sale',
    TO_DATE('2024-02-01', 'YYYY-MM-DD'),
    TO_DATE('2024-02-14', 'YYYY-MM-DD'),
    0.15
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    9,
    'Spring Clearance',
    TO_DATE('2024-04-01', 'YYYY-MM-DD'),
    TO_DATE('2024-04-15', 'YYYY-MM-DD'),
    0.3
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    10,
    'Easter Special',
    TO_DATE('2024-04-16', 'YYYY-MM-DD'),
    TO_DATE('2024-04-20', 'YYYY-MM-DD'),
    0.2
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    11,
    'Mother''s Day Sale',
    TO_DATE('2024-05-01', 'YYYY-MM-DD'),
    TO_DATE('2024-05-10', 'YYYY-MM-DD'),
    0.25
);

INSERT INTO gpnr_promotion (
    promotion_id,
    promotion_name,
    start_date,
    end_date,
    promotion_discount
) VALUES (
    12,
    'Memorial Day Weekend',
    TO_DATE('2024-05-25', 'YYYY-MM-DD'),
    TO_DATE('2024-05-28', 'YYYY-MM-DD'),
    0.2
);

CREATE SEQUENCE seq_gpnr_cart_id START WITH 1001 INCREMENT BY 1;

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2023-05-10 08:00:00',
    'checked out',
    'jane_doe'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    7,
    5
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    9,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    8,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    2,
    7
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2023-06-15 08:15:00',
    'checked out',
    'john_smith'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    3,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    7,
    4
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    11,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    9,
    3
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    2,
    2
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2023-07-20 08:30:00',
    'checked out',
    'mike_jones'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    2,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    10,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    9,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    16,
    3
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    7,
    2
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2023-08-25 08:45:00',
    'checked out',
    'amy_wong'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    6,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    2,
    4
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    7,
    1
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2023-09-30 09:00:00',
    'checked out',
    'brian_smith'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    2,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    7,
    3
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    4,
    3
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    20,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    23,
    1
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2023-10-05 09:15:00',
    'checked out',
    'sarah_brown'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    15,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    21,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    22,
    3
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    7,
    1
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2023-11-10 09:30:00',
    'checked out',
    'david_kim'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    13,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    18,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    25,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    27,
    2
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2023-12-15 09:45:00',
    'checked out',
    'lisa_miller'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    24,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    26,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    28,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    29,
    1
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2024-01-20 10:00:00',
    'checked out',
    'kevin_lee'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    9,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    17,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    30,
    3
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2024-02-25 10:15:00',
    'checked out',
    'emily_taylor'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    2,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    7,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    13,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    20,
    1
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2024-03-30 10:30:00',
    'checked out',
    'jane_doe'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    3,
    3
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    11,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    9,
    1
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2024-04-05 10:45:00',
    'checked out',
    'john_smith'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    5,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    16,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    23,
    3
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2024-04-10 11:00:00',
    'pending',
    'mike_jones'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    4,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    9,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    18,
    2
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    24,
    1
);

INSERT INTO gpnr_cart (
    cart_id,
    cart_created_at,
    cart_status,
    customer_username
) VALUES (
    seq_gpnr_cart_id.NEXTVAL,
    TIMESTAMP '2024-04-15 11:15:00',
    'pending',
    'amy_wong'
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    6,
    3
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    12,
    1
);

INSERT INTO gpnr_product_cart (
    cart_id,
    product_id,
    cart_product_quantity
) VALUES (
    seq_gpnr_cart_id.CURRVAL,
    21,
    2
);

CREATE OR REPLACE PROCEDURE process_product_cart (
    p_cart_id IN NUMBER
) AS
    lv_cart_count NUMBER;
BEGIN
    SELECT
        COUNT(*) INTO lv_cart_count
    FROM
        gpnr_cart
    WHERE
        cart_id = p_cart_id;
    IF lv_cart_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Cart ID does not exist.');
    END IF;
    UPDATE gpnr_cart
    SET
        cart_status = 'checked out'
    WHERE
        cart_id = p_cart_id;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

BEGIN
    process_product_cart(
        p_cart_id => 1013
    );
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

-- Trigger to update the stock quantity of a product after inserting to a cart
CREATE OR REPLACE TRIGGER update_product_stock AFTER
    INSERT ON gpnr_product_cart FOR EACH ROW
DECLARE
    -- Declare a variable to hold the quantity of the product in stock
    lv_quantity NUMBER;
BEGIN
    -- Retrieve the current quantity of the product from the gpnr_product table
    SELECT
        product_quantity INTO lv_quantity
    FROM
        gpnr_product
    WHERE
        product_id = :NEW.product_id;
    -- Check if the quantity in stock is less than the quantity being added to the cart
    IF lv_quantity < :NEW.cart_product_quantity THEN
        -- If there's insufficient stock, raise an error
        RAISE_APPLICATION_ERROR(-20003, 'Insufficient stock for product ID '
                                        || TO_CHAR(:NEW.product_id));
    ELSE
        -- If there's sufficient stock, update the product quantity in the gpnr_product table
        UPDATE gpnr_product
        SET
            product_quantity = lv_quantity - :NEW.cart_product_quantity
        WHERE
            product_id = :NEW.product_id;
    END IF;
END;
/

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    1,
    'Credit Card',
    0.02
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    2,
    'Debit Card',
    0.01
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    3,
    'Bank Transfer',
    0.03
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    4,
    'E-Wallet',
    0.00
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    5,
    'Cryptocurrency',
    0.05
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    6,
    'Buy Now, Pay Later',
    0.00
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    7,
    'Mobile Payment',
    0.01
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    8,
    'Gift Card',
    0.00
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    9,
    'Prepaid Card',
    0.00
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    10,
    'Cash on Delivery',
    0.00
);

INSERT INTO gpnr_payment_method (
    payment_method_id,
    payment_name,
    payment_method_discount
) VALUES (
    11,
    'Check',
    0.00
);

CREATE OR REPLACE FUNCTION get_customer_district(
    p_username IN VARCHAR2
) RETURN VARCHAR2 IS
    lv_district VARCHAR2(100);
BEGIN
    SELECT
        d.district INTO lv_district
    FROM
        gpnr_customer c
        JOIN gpnr_district d
        -- Extracting the substring starting from the first comma position in the address
        ON SUBSTR(c.customer_address,
        -- Finding the position of the first comma in the address
        INSTR(c.customer_address,
        ',',
        1,
        -- Adding 2 to skip the comma and space to match the district
        1) + 2) = d.district
    WHERE
        c.customer_username = p_username;
    RETURN lv_district;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

DECLARE
    -- Declare variables for various data needed for shipment creation
    lv_shipping_date      DATE;
    lv_customer_district  gpnr_district.district%TYPE;
    lv_cart_created_date  DATE;
    lv_shipper_username   gpnr_shipment.shipper_username%TYPE;
    lv_district_id        gpnr_shipment.district_id%TYPE;
    lv_district_tax       gpnr_district.tax%TYPE;
    lv_shipping_cost      gpnr_district.shipping_cost%TYPE;
    lv_payment_discount   gpnr_payment_method.payment_method_discount%TYPE;
    lv_cart_total         NUMBER(12, 2);
    lv_promotion_discount NUMBER(12, 2);
    lv_total              gpnr_shipment.total%TYPE;
    lv_promotion_id       gpnr_shipment.promotion_id%TYPE;
    lv_payment_method_id  gpnr_shipment.payment_method_id%TYPE;
    lv_shipping_status    gpnr_shipment.shipping_status%TYPE;
    
    -- Declare cursor for fetching checked out carts
    CURSOR c_checked_out_carts IS
        SELECT
            c.cart_id,
            c.customer_username,
            c.cart_created_at
        FROM
            gpnr_cart c
        WHERE
            c.cart_status = 'checked out';
BEGIN
    -- Iterate through checked out carts to create shipments
    FOR cart_rec IN c_checked_out_carts LOOP
        -- Get customer district, cart creation date, and initialize cart total
        lv_customer_district := get_customer_district(cart_rec.customer_username);
        lv_cart_created_date := cart_rec.cart_created_at;
        lv_cart_total := 0;
        
        -- Calculate total cart value by iterating through cart products
        FOR cart_prod_rec IN (
            SELECT
                pc.product_id,
                pc.cart_product_quantity
            FROM
                gpnr_product_cart pc
            WHERE
                pc.cart_id = cart_rec.cart_id
        ) LOOP
            SELECT
                p.price * cart_prod_rec.cart_product_quantity INTO lv_cart_total
            FROM
                gpnr_product p
            WHERE
                p.product_id = cart_prod_rec.product_id;
        END LOOP;
        
        -- Randomly select a shipper username
        SELECT
            shipper_username INTO lv_shipper_username
        FROM
            gpnr_shipper
        ORDER BY
            DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY;
        
        -- Update shipment status to "shipped" after selecting shipper username
        lv_shipping_status := 'shipped';
        
        -- Retrieve district details based on customer district
        SELECT
            d.district_id,
            d.tax,
            d.shipping_cost INTO lv_district_id,
            lv_district_tax,
            lv_shipping_cost
        FROM
            gpnr_district d
        WHERE
            d.district = lv_customer_district;
        
        -- Randomly select a payment method and its discount
        SELECT
            pm.payment_method_id,
            pm.payment_method_discount INTO lv_payment_method_id,
            lv_payment_discount
        FROM
            gpnr_payment_method pm
        ORDER BY
            DBMS_RANDOM.VALUE FETCH FIRST 1 ROWS ONLY;
        
        -- Try to retrieve applicable promotion discount for the cart creation date
        BEGIN
            SELECT
                promotion_id,
                promotion_discount INTO lv_promotion_id,
                lv_promotion_discount
            FROM
                gpnr_promotion
            WHERE
                start_date <= lv_cart_created_date
                AND end_date >= lv_cart_created_date;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                lv_promotion_discount := 0;
        END;
        
        -- Calculate total shipment cost considering discounts and taxes
        lv_total := lv_cart_total * (1 - lv_promotion_discount) * (1 + lv_district_tax) + lv_shipping_cost;
        lv_total := lv_total * (1 - lv_payment_discount);
        
        -- Generate a random shipping date within a week from the cart creation date
        lv_shipping_date := lv_cart_created_date + TRUNC(DBMS_RANDOM.VALUE(1, 7));
        
        -- Insert shipment details into gpnr_shipment table
        INSERT INTO gpnr_shipment (
            cart_id,
            shipping_date,
            shipping_status,
            total,
            shipper_username,
            promotion_id,
            district_id,
            payment_method_id
        ) VALUES (
            cart_rec.cart_id,
            lv_shipping_date,
            lv_shipping_status,
            lv_total,
            lv_shipper_username,
            lv_promotion_id,
            lv_district_id,
            lv_payment_method_id
        );
    END LOOP;
    
    -- Commit the transaction
    COMMIT;
END;
/

-- Indexes to enhance the query to retrieve a list of products sorted in descending order of total sales
CREATE INDEX idx_checked_out_products ON gpnr_cart (cart_status, cart_id);
CREATE INDEX idx_product_cart ON gpnr_product_cart (cart_id, product_id, cart_product_quantity);
CREATE INDEX idx_product_id_name ON gpnr_product (product_id, product_name);

-- Query to retrieve a list of products sorted in descending order of total sales
SELECT
    p.product_id,
    p.product_name,
    SUM(pc.cart_product_quantity) AS total_sold
-- Get product details and sales data
FROM
    gpnr_product p
    JOIN gpnr_product_cart pc ON p.product_id = pc.product_id
    -- Link sales data with cart information
    JOIN gpnr_cart c ON pc.cart_id = c.cart_id
WHERE
    c.cart_status = 'checked out'
-- Aggregate sales data for each product
GROUP BY
    p.product_id,
    p.product_name
-- Show the best-selling products first
ORDER BY
    total_sold DESC;
