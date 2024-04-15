CREATE OR REPLACE FUNCTION calculate_cart_total(cart_id_param IN NUMBER)
RETURN NUMBER
IS
    v_subtotal NUMBER(12, 2);
    v_tax NUMBER(12, 2);
    v_shipping_cost NUMBER(12, 2);
    v_discount NUMBER(5, 2);
    v_total NUMBER(12, 2);
BEGIN
    SELECT SUM(p.price * pc.product_cart_quantity)
    INTO v_subtotal
    FROM gpnr_product p
    JOIN gpnr_product_cart pc ON p.product_id = pc.product_id
    WHERE pc.cart_id = cart_id_param;

    SELECT NVL(SUM(s.shipping_cost), 0)
    INTO v_shipping_cost
    FROM gpnr_shipping s
    JOIN gpnr_cart c ON s.shipping_id = c.shipping_id
    WHERE c.cart_id = cart_id_param;

    SELECT NVL(SUM(c.cart_discount), 0)
    INTO v_discount
    FROM gpnr_cart c
    WHERE c.cart_id = cart_id_param;

    v_tax := 0.1 * v_subtotal;

    v_total := v_subtotal + v_tax + v_shipping_cost - v_discount;

    RETURN v_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0; -- Return 0 if no data found
END;
/
