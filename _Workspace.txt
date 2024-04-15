CREATE OR REPLACE FUNCTION calculate_shipping_cost(
    p_weight NUMBER
) RETURN NUMBER IS
    lv_cost_per_kg   NUMBER := 1.5;
    lv_base_cost     NUMBER := 5;
    lv_shipping_cost NUMBER;
BEGIN
    lv_shipping_cost := lv_base_cost + (p_weight * lv_cost_per_kg);
    RETURN lv_shipping_cost;
END calculate_shipping_cost;
/

CREATE OR REPLACE FUNCTION format_phone_number(
    p_phone_number VARCHAR2
) RETURN VARCHAR2 IS
    v_formatted_number VARCHAR2(20);
BEGIN
    p_phone_number := REGEXP_REPLACE(p_phone_number, '[^0-9]', '');
    IF LENGTH(p_phone_number) = 10 THEN
        v_formatted_number := '('
                              || SUBSTR(p_phone_number, 1, 3)
                                 || ') '
                                 || SUBSTR(p_phone_number, 4, 3)
                                    || '-'
                                    || SUBSTR(p_phone_number, 7);
    ELSE
        v_formatted_number := NULL;
    END IF;

    RETURN v_formatted_number;
END format_phone_number;
/

