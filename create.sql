CREATE TABLE gpnr_category (
    category_id NUMBER(10) NOT NULL PRIMARY KEY,
    category_name VARCHAR2(255) NOT NULL,
    category_description CLOB,
    parent_category_id NUMBER(10),
    FOREIGN KEY (parent_category_id) REFERENCES gpnr_category(category_id)
);

CREATE TABLE gpnr_payment_info (
    payment_info_id NUMBER(10) NOT NULL PRIMARY KEY,
    payment_info_name VARCHAR2(255) NOT NULL,
    card_number VARCHAR2(19) NOT NULL,
    card_name VARCHAR2(255) NOT NULL,
    card_expiration DATE NOT NULL,
    card_cvv CHAR(4) NOT NULL
);

CREATE TABLE gpnr_customer (
    customer_username VARCHAR2(255) NOT NULL PRIMARY KEY,
    customer_password VARCHAR2(255) NOT NULL,
    customer_email VARCHAR2(255) NOT NULL,
    customer_firstname VARCHAR2(255) NOT NULL,
    customer_lastname VARCHAR2(255) NOT NULL,
    customer_address CLOB,
    customer_phone VARCHAR2(20),
    payment_info_id NUMBER(10),
    FOREIGN KEY (payment_info_id) REFERENCES gpnr_payment_info(payment_info_id)
);

CREATE TABLE gpnr_product_attribute (
    product_attribute_id NUMBER(10) NOT NULL PRIMARY KEY,
    product_attribute_name VARCHAR2(255) NOT NULL,
    product_attribute_status VARCHAR2(10) CHECK(product_attribute_status IN ('active', 'inactive')) NOT NULL DEFAULT 'active',
    value CLOB
);

CREATE TABLE GPNR_PRODUCT (
    PRODUCT_ID NUMBER(10) NOT NULL PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(255) NOT NULL,
    PRODUCT_DESCRIPTION CLOB,
    PRODUCT_CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRODUCT_STATUS VARCHAR2(15) CHECK(PRODUCT_STATUS IN ('available', 'out_of_stock', 'discontinued')) NOT NULL DEFAULT 'available',
    PRICE DECIMAL(10, 2) NOT NULL,
    CURRENCY CHAR(3) NOT NULL,
    STOCK NUMBER(10) NOT NULL DEFAULT 0,
    CATEGORY_ID NUMBER(10),
    PRODUCT_ATTRIBUTE_ID NUMBER(10),
    FOREIGN KEY (CATEGORY_ID) REFERENCES GPNR_CATEGORY(CATEGORY_ID),
    FOREIGN KEY (PRODUCT_ATTRIBUTE_ID) REFERENCES GPNR_PRODUCT_ATTRIBUTE(PRODUCT_ATTRIBUTE_ID)
);

CREATE TABLE GPNR_REQUEST (
    REQUEST_ID NUMBER(10) NOT NULL PRIMARY KEY,
    REQUEST_COST DECIMAL(10, 2) NOT NULL,
    REQUEST_QUANTITY NUMBER(10) NOT NULL DEFAULT 1,
    REQUEST_CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    REQUEST_STATUS VARCHAR2(15) CHECK(REQUEST_STATUS IN ('pending', 'processing', 'completed', 'cancelled')) NOT NULL DEFAULT 'pending',
    PRODUCT_QUANTITY NUMBER(10) NOT NULL DEFAULT 1,
    MESSAGE CLOB,
    CUSTOMER_USERNAME VARCHAR2(255),
    PRODUCT_ID NUMBER(10),
    FOREIGN KEY (CUSTOMER_USERNAME) REFERENCES GPNR_CUSTOMER(CUSTOMER_USERNAME),
    FOREIGN KEY (PRODUCT_ID) REFERENCES GPNR_PRODUCT(PRODUCT_ID)
);

CREATE TABLE gpnr_shipper (
    shipper_username VARCHAR2(255) NOT NULL PRIMARY KEY,
    shipper_password VARCHAR2(255) NOT NULL,
    shipper_email VARCHAR2(255) NOT NULL,
    shipper_firstname VARCHAR2(255) NOT NULL,
    shipper_lastname VARCHAR2(255) NOT NULL,
    shipper_phone VARCHAR2(20),
    shipper_rating DECIMAL(3, 2) NOT NULL DEFAULT 0
);

CREATE TABLE GPNR_SHIPPING (
    SHIPPING_ID NUMBER(10) NOT NULL PRIMARY KEY,
    SHIPPING_DATE TIMESTAMP NOT NULL,
    SHIPPING_ADDRESS CLOB,
    SHIPPING_STATUS VARCHAR2(15) CHECK(SHIPPING_STATUS IN ('shipped', 'delivered')) NOT NULL DEFAULT 'shipped',
    SHIPPING_COST DECIMAL(10, 2) NOT NULL,
    SHIPPING_RATING DECIMAL(3, 2) NOT NULL DEFAULT 0,
    SHIPPER_USERNAME VARCHAR2(255),
    FOREIGN KEY (SHIPPER_USERNAME) REFERENCES GPNR_SHIPPER(SHIPPER_USERNAME)
);

CREATE TABLE GPNR_CART (
    CART_ID NUMBER(10) NOT NULL PRIMARY KEY,
    CART_STATUS VARCHAR2(15) CHECK(CART_STATUS IN ('active', 'completed', 'cancelled')) NOT NULL DEFAULT 'active',
    CART_CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CART_PROMOTION DECIMAL(10, 2) NOT NULL DEFAULT 0,
    TOTAL DECIMAL(10, 2) NOT NULL,
    TAX DECIMAL(10, 2) NOT NULL DEFAULT 0,
    PRODUCT_QUANTITY NUMBER(10) NOT NULL DEFAULT 1,
    CUSTOMER_USERNAME VARCHAR2(255),
    PRODUCT_ID NUMBER(10),
    SHIPPING_ID NUMBER(10),
    FOREIGN KEY (CUSTOMER_USERNAME) REFERENCES GPNR_CUSTOMER(CUSTOMER_USERNAME),
    FOREIGN KEY (PRODUCT_ID) REFERENCES GPNR_PRODUCT(PRODUCT_ID),
    FOREIGN KEY (SHIPPING_ID) REFERENCES GPNR_SHIPPING(SHIPPING_ID)
);

CREATE TABLE gpnr_supplier (
    supplier_username VARCHAR2(255) NOT NULL PRIMARY KEY,
    supplier_password VARCHAR2(255) NOT NULL,
    supplier_email VARCHAR2(255) NOT NULL,
    supplier_firstname VARCHAR2(255) NOT NULL,
    supplier_lastname VARCHAR2(255) NOT NULL,
    supplier_phone VARCHAR2(20)
);

CREATE TABLE gpnr_supplier_product (
    supplier_username VARCHAR2(255),
    product_id NUMBER(10),
    PRIMARY KEY (supplier_username, product_id),
    FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id),
    FOREIGN KEY (supplier_username) REFERENCES gpnr_supplier(supplier_username)
);

CREATE TABLE gpnr_promotion (
    promotion_id NUMBER(10) NOT NULL PRIMARY KEY,
    promotion_name VARCHAR2(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE gpnr_customer_promotion (
    promotion_id NUMBER(10),
    customer_username VARCHAR2(255),
    PRIMARY KEY (promotion_id, customer_username),
    FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username),
    FOREIGN KEY (promotion_id) REFERENCES gpnr_promotion(promotion_id)
);
