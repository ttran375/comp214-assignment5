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
    product_attribute_status VARCHAR2(10) DEFAULT 'active' CHECK (product_attribute_status IN ('active', 'inactive')),
    value CLOB
);

CREATE TABLE gpnr_product (
    product_id NUMBER(10) NOT NULL PRIMARY KEY,
    product_name VARCHAR2(255) NOT NULL,
    product_description CLOB,
    product_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    product_status VARCHAR2(15) DEFAULT 'available' NOT NULL CHECK (product_status IN ('available', 'out_of_stock', 'discontinued')),
    price NUMBER(10, 2) NOT NULL,
    currency CHAR(3) NOT NULL,
    stock NUMBER(10) DEFAULT 0 NOT NULL,
    category_id NUMBER(10),
    product_attribute_id NUMBER(10),
    FOREIGN KEY (category_id) REFERENCES gpnr_category(category_id),
    FOREIGN KEY (product_attribute_id) REFERENCES gpnr_product_attribute(product_attribute_id)
);

CREATE TABLE gpnr_request (
    request_id NUMBER(10) NOT NULL PRIMARY KEY,
    request_cost NUMBER(10, 2) NOT NULL,
    request_quantity NUMBER(10) DEFAULT 1 NOT NULL,
    request_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    request_status VARCHAR2(15) DEFAULT 'pending' NOT NULL CHECK (request_status IN ('pending', 'processing', 'completed', 'cancelled')),
    product_quantity NUMBER(10) DEFAULT 1 NOT NULL,
    message CLOB,
    customer_username VARCHAR2(255),
    product_id NUMBER(10),
    FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username),
    FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id)
);

CREATE TABLE gpnr_shipper (
    shipper_username VARCHAR2(255) NOT NULL PRIMARY KEY,
    shipper_password VARCHAR2(255) NOT NULL,
    shipper_email VARCHAR2(255) NOT NULL,
    shipper_firstname VARCHAR2(255) NOT NULL,
    shipper_lastname VARCHAR2(255) NOT NULL,
    shipper_phone VARCHAR2(20),
    shipper_rating NUMBER(5, 2) DEFAULT 0 NOT NULL
);

CREATE TABLE gpnr_shipping (
    shipping_id NUMBER(10) NOT NULL PRIMARY KEY,
    shipping_date TIMESTAMP NOT NULL,
    shipping_address CLOB,
    shipping_status VARCHAR2(15) DEFAULT 'shipped' NOT NULL CHECK (shipping_status IN ('shipped', 'delivered')),
    shipping_cost NUMBER(10, 2) NOT NULL,
    shipping_rating NUMBER(5, 2) DEFAULT 0 NOT NULL,
    shipper_username VARCHAR2(255),
    FOREIGN KEY (shipper_username) REFERENCES gpnr_shipper(shipper_username)
);

CREATE TABLE gpnr_cart (
    cart_id NUMBER(10) NOT NULL PRIMARY KEY,
    cart_status VARCHAR2(15) DEFAULT 'active' NOT NULL CHECK (cart_status IN ('active', 'completed', 'cancelled')),
    cart_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    cart_promotion NUMBER(10, 2) DEFAULT 0 NOT NULL,
    total NUMBER(10, 2) NOT NULL,
    tax NUMBER(10, 2) DEFAULT 0 NOT NULL,
    product_quantity NUMBER(10) DEFAULT 1 NOT NULL,
    customer_username VARCHAR2(255),
    product_id NUMBER(10),
    shipping_id NUMBER(10),
    FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username),
    FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id),
    FOREIGN KEY (shipping_id) REFERENCES gpnr_shipping(shipping_id)
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
    amount NUMBER(10, 2) NOT NULL
);

CREATE TABLE gpnr_customer_promotion (
    promotion_id NUMBER(10),
    customer_username VARCHAR2(255),
    PRIMARY KEY (promotion_id, customer_username),
    FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username),
    FOREIGN KEY (promotion_id) REFERENCES gpnr_promotion(promotion_id)
);
