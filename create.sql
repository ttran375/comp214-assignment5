CREATE TABLE gpnr_shipper (
  shipper_username VARCHAR2(255),
  shipper_password VARCHAR2(255),
  shipper_email VARCHAR2(255),
  shipper_firstname VARCHAR2(255),
  shipper_lastname VARCHAR2(255),
  shipper_phone VARCHAR2(10),
  shipper_rating NUMBER(3, 2),
  PRIMARY KEY (shipper_username)
);

CREATE TABLE gpnr_supplier (
  supplier_username VARCHAR2(255),
  supplier_password VARCHAR2(255),
  supplier_email VARCHAR2(255),
  supplier_name VARCHAR2(255),
  supplier_description CLOB,
  supplier_phone VARCHAR2(10),
  PRIMARY KEY (supplier_username)
);

CREATE TABLE gpnr_category (
  category_id INT GENERATED ALWAYS AS IDENTITY,
  category_name VARCHAR2(255),
  category_description CLOB,
  parent_category_id INT,
  PRIMARY KEY (category_id),
  FOREIGN KEY (parent_category_id) REFERENCES gpnr_category(category_id)
);

CREATE TABLE gpnr_product_attribute (
  product_attribute_id INT GENERATED ALWAYS AS IDENTITY,
  product_attribute_name VARCHAR2(255),
  value VARCHAR2(255),
  PRIMARY KEY (product_attribute_id)
);

CREATE TABLE gpnr_payment_info (
  payment_info_id INT GENERATED ALWAYS AS IDENTITY,
  card_type VARCHAR2(20),
  card_number NUMBER(19, 0),
  card_name VARCHAR2(255),
  expiration DATE,
  cvv VARCHAR2(4),
  PRIMARY KEY (payment_info_id)
);

CREATE TABLE gpnr_promotion (
  promotion_id INT GENERATED ALWAYS AS IDENTITY,
  promotion_name VARCHAR2(255),
  start_date DATE,
  end_date DATE,
  promotion_amount NUMBER(10, 2),
  PRIMARY KEY (promotion_id)
);

CREATE TABLE gpnr_customer (
  customer_username VARCHAR2(255),
  customer_password VARCHAR2(255),
  customer_email VARCHAR2(255),
  customer_firstname VARCHAR2(255),
  customer_lastname VARCHAR2(255),
  customer_address VARCHAR2(255),
  customer_phone VARCHAR2(10),
  payment_info_id INT,
  PRIMARY KEY (customer_username),
  FOREIGN KEY (payment_info_id) REFERENCES gpnr_payment_info(payment_info_id)
);

CREATE TABLE gpnr_request (
  request_id INT GENERATED ALWAYS AS IDENTITY,
  request_cost NUMBER(10, 2),
  request_quantity INT,
  request_created_at TIMESTAMP,
  request_status VARCHAR2(255),
  message CLOB,
  customer_username VARCHAR2(255),
  PRIMARY KEY (request_id),
  FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username)
);

CREATE TABLE gpnr_product (
  product_id INT GENERATED ALWAYS AS IDENTITY,
  product_name VARCHAR2(255),
  product_description CLOB,
  product_created_at TIMESTAMP,
  product_status VARCHAR2(255),
  price NUMBER(10, 2),
  currency CHAR(3),
  product_quantity INT,
  category_id INT,
  product_attribute_id INT,
  PRIMARY KEY (product_id),
  FOREIGN KEY (category_id) REFERENCES gpnr_category(category_id),
  FOREIGN KEY (product_attribute_id) REFERENCES gpnr_product_attribute(product_attribute_id)
);

CREATE TABLE gpnr_product_request (
  product_id INT,
  request_id INT,
  product_request_quantity INT,
  PRIMARY KEY (product_id, request_id),
  FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id),
  FOREIGN KEY (request_id) REFERENCES gpnr_request(request_id)
);

CREATE TABLE gpnr_shipping (
  shipping_id INT GENERATED ALWAYS AS IDENTITY,
  shipping_date TIMESTAMP,
  shipping_address VARCHAR2(255),
  shipping_status VARCHAR2(255),
  shipping_cost NUMBER(10, 2),
  shipping_rating NUMBER(3, 2),
  shipper_username VARCHAR2(255),
  PRIMARY KEY (shipping_id),
  FOREIGN KEY (shipper_username) REFERENCES gpnr_shipper(shipper_username)
);

CREATE TABLE gpnr_cart (
  cart_id INT GENERATED ALWAYS AS IDENTITY,
  cart_status VARCHAR2(255),
  cart_created_at TIMESTAMP,
  cart_promotion_amount NUMBER(10, 2),
  total NUMBER(10, 2),
  tax NUMBER(10, 2),
  customer_username VARCHAR2(255),
  shipping_id INT,
  PRIMARY KEY (cart_id),
  FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username),
  FOREIGN KEY (shipping_id) REFERENCES gpnr_shipping(shipping_id)
);

CREATE TABLE gpnr_product_cart (
  product_id INT,
  cart_id INT,
  product_cart_quantity INT,
  PRIMARY KEY (product_id, cart_id),
  FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id),
  FOREIGN KEY (cart_id) REFERENCES gpnr_cart(cart_id)
);

CREATE TABLE gpnr_supplier_product (
  supplier_username VARCHAR2(255),
  product_id INT,
  PRIMARY KEY (supplier_username, product_id),
  FOREIGN KEY (product_id) REFERENCES gpnr_product(product_id),
  FOREIGN KEY (supplier_username) REFERENCES gpnr_supplier(supplier_username)
);

CREATE TABLE gpnr_customer_promotion (
  promotion_id INT,
  customer_username VARCHAR2(255),
  PRIMARY KEY (promotion_id, customer_username),
  FOREIGN KEY (customer_username) REFERENCES gpnr_customer(customer_username),
  FOREIGN KEY (promotion_id) REFERENCES gpnr_promotion(promotion_id)
);
