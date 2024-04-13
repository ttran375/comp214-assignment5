CREATE TABLE `gpnr_category` (
  `category_id` int,
  `category_name` varchar(255),
  `category_description` varchar(255),
  `parent_category_id` int,
  PRIMARY KEY (`category_id`),
  FOREIGN KEY (`parent_category_id`) REFERENCES `gpnr_category`(`category_id`)
);

CREATE TABLE `gpnr_payment_info` (
  `payment_info_id` int,
  `payment_info_name` int,
  `card_number` int,
  `card_name` int,
  `card_expiration` date,
  `card_cvv` varchar(255),
  PRIMARY KEY (`payment_info_id`)
);

CREATE TABLE `gpnr_customer` (
  `customer_username` varchar(255),
  `customer_password` varchar(255),
  `customer_email` varchar(255),
  `customer_firstname` varchar(255),
  `customer_lastname` varchar(255),
  `customer_address` varchar(255),
  `customer_phone` varchar(10),
  `payment_info_id` int,
  PRIMARY KEY (`customer_username`),
  FOREIGN KEY (`payment_info_id`) REFERENCES `gpnr_payment_info`(`payment_info_id`)
);

CREATE TABLE `gpnr_product_attribute` (
  `product_attribute_id` int,
  `product_attribute_name` varchar(255),
  `product_attribute_status` varchar(255),
  `value` varchar(255),
  PRIMARY KEY (`product_attribute_id`)
);

CREATE TABLE `gpnr_product` (
  `product_id` int,
  `product_name` varchar(255),
  `product_description` varchar(255),
  `product_created_at` date,
  `product_status` varchar(255),
  `price` decimal,
  `currency` char(3),
  `stock` int,
  `category_id` int,
  `product_attribute_id` int,
  PRIMARY KEY (`product_id`),
  FOREIGN KEY (`category_id`) REFERENCES `gpnr_category`(`category_id`),
  FOREIGN KEY (`product_attribute_id`) REFERENCES `gpnr_product_attribute`(`product_attribute_id`)
);

CREATE TABLE `gpnr_request` (
  `request_id` int,
  `request_cost` decimal,
  `request_quantity` int,
  `request_created_at` date,
  `request_status` varchar(255),
  `product_quantity` int,
  `message` varchar(255),
  `customer_username` varchar(255),
  `product_id` int,
  PRIMARY KEY (`request_id`),
  FOREIGN KEY (`customer_username`) REFERENCES `gpnr_customer`(`customer_username`),
  FOREIGN KEY (`product_id`) REFERENCES `gpnr_product`(`product_id`)
);

CREATE TABLE `gpnr_shipper` (
  `shipper_username` varchar(255),
  `shipper_password` varchar(255),
  `shipper_email` varchar(255),
  `shipper_firstname` varchar(255),
  `shipper_lastname` varchar(255),
  `shipper_phone` varchar(10),
  `shipper_rating` int,
  PRIMARY KEY (`shipper_username`)
);

CREATE TABLE `gpnr_shipping` (
  `shipping_id` int,
  `shipping_date` date,
  `shipping_address` varchar(255),
  `shipping_status` varchar(255),
  `shipping_cost` decimal,
  `shipping_rating` int,
  `shipper_username` varchar(255),
  PRIMARY KEY (`shipping_id`),
  FOREIGN KEY (`shipper_username`) REFERENCES `gpnr_shipper`(`shipper_username`)
);

CREATE TABLE `gpnr_cart` (
  `cart_id` int,
  `cart_status` varchar(255),
  `cart_created_at` date,
  `cart_promotion` decimal,
  `total` decimal,
  `tax` decimal,
  `product_quantity` int,
  `customer_username` varchar(255),
  `product_id` int,
  `shipping_id` int,
  PRIMARY KEY (`cart_id`),
  FOREIGN KEY (`customer_username`) REFERENCES `gpnr_customer`(`customer_username`),
  FOREIGN KEY (`product_id`) REFERENCES `gpnr_product`(`product_id`),
  FOREIGN KEY (`shipping_id`) REFERENCES `gpnr_shipping`(`shipping_id`)
);

CREATE TABLE `gpnr_supplier` (
  `supplier_username` varchar(255),
  `supplier_password` varchar(255),
  `supplier_email` varchar(255),
  `supplier_firstname` varchar(255),
  `supplier_lastname` varchar(255),
  `supplier_phone` varchar(10),
  PRIMARY KEY (`supplier_username`)
);

CREATE TABLE `gpnr_supplier_product` (
  `supplier_username` varchar(255),
  `product_id` int,
  PRIMARY KEY (`supplier_username`, `product_id`),
  FOREIGN KEY (`product_id`) REFERENCES `gpnr_product`(`product_id`),
  FOREIGN KEY (`supplier_username`) REFERENCES `gpnr_supplier`(`supplier_username`)
);

CREATE TABLE `gpnr_promotion` (
  `promotion_id` int,
  `promotion_name` varchar(255),
  `start_date` date,
  `end_date` date,
  `amount` decimal,
  PRIMARY KEY (`promotion_id`)
);

CREATE TABLE `gpnr_customer_promotion` (
  `promotion_id` int,
  `customer_username` varchar(255),
  PRIMARY KEY (`promotion_id`, `customer_username`),
  FOREIGN KEY (`customer_username`) REFERENCES `gpnr_customer`(`customer_username`),
  FOREIGN KEY (`promotion_id`) REFERENCES `gpnr_promotion`(`promotion_id`)
);
