CREATE OR REPLACE FUNCTION calculate_shipping_cost(
    p_weight NUMBER
)
RETURN NUMBER
IS
    lv_cost_per_kg NUMBER := 1.5;
    lv_base_cost NUMBER := 5;
    lv_shipping_cost NUMBER;
BEGIN
   
    lv_shipping_cost := lv_base_cost + (p_weight * lv_cost_per_kg);

    RETURN lv_shipping_cost;
END calculate_shipping_cost;
/
