SELECT 
    city.city_name, 
    product.product_name, 
    ROUND(SUM(invoice_item.line_total_price), 2) AS total_price
FROM 
    city
INNER JOIN 
    customer ON city.id = customer.city_id
INNER JOIN 
    invoice ON customer.id = invoice.customer_id
INNER JOIN 
    invoice_item ON invoice.id = invoice_item.invoice_id
INNER JOIN 
    product ON invoice_item.product_id = product.id
GROUP BY 
    city.city_name, product.product_name 
ORDER BY 
    total_price DESC, city.city_name, product.product_name;
