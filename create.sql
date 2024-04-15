CREATE TABLE gpnr_shipper (
    shipper_username VARCHAR2(20) PRIMARY KEY,
    shipper_password VARCHAR2(255),
    shipper_email VARCHAR2(255),
    shipper_firstname VARCHAR2(255),
    shipper_lastname VARCHAR2(255),
    shipper_phone VARCHAR2(15),
    shipper_rating NUMBER(5, 2)
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

CREATE TABLE gpnr_promotion (
    promotion_id NUMBER(10) PRIMARY KEY,
    promotion_name VARCHAR2(255),
    start_date DATE,
    end_date DATE,
    discount NUMBER(5, 2)
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
    weight NUMBER(4, 2),
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

CREATE TABLE gpnr_payment_info (
    payment_info_id NUMBER(10) PRIMARY KEY,
    card_number NUMBER(19),
    card_name VARCHAR2(255),
    card_expiration DATE,
    card_cvv VARCHAR2(4),
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

CREATE TABLE gpnr_customer_promotion (
    customer_username VARCHAR2(20),
    promotion_id NUMBER(10),
    PRIMARY KEY (customer_username, promotion_id),
    CONSTRAINT fk_cust_prom_customer FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username),
    CONSTRAINT fk_cust_prom_promotion FOREIGN KEY (promotion_id) REFERENCES gpnr_promotion(promotion_id)
);

CREATE TABLE gpnr_product_request (
    product_id NUMBER(10),
    request_id NUMBER(10),
    product_request_quantity NUMBER(10),
    PRIMARY KEY (product_id, request_id),
    CONSTRAINT fk_product_request_request FOREIGN KEY (request_id) REFERENCES gpnr_request(request_id),
    CONSTRAINT fk_product_request_product FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

CREATE TABLE gpnr_product_cart (
    product_id NUMBER(10),
    cart_id NUMBER(10),
    product_cart_quantity NUMBER(10),
    PRIMARY KEY (product_id, cart_id),
    CONSTRAINT fk_product_cart_cart FOREIGN KEY (cart_id) REFERENCES gpnr_cart(cart_id),
    CONSTRAINT fk_product_cart_product FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

CREATE SEQUENCE seq_gpnr_category_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_gpnr_product_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_gpnr_product_attribute_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_gpnr_payment_info_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_gpnr_promotion_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_gpnr_request_id START WITH 100 INCREMENT BY 1;
CREATE SEQUENCE seq_gpnr_cart_id START WITH 100 INCREMENT BY 1;
CREATE SEQUENCE seq_gpnr_shipping_id START WITH 100 INCREMENT BY 1;
