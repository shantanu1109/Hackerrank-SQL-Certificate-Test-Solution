SELECT product.sku, product.product_name
FROM product
LEFT JOIN invoice_item ON product.id = invoice_item.product_id
WHERE invoice_item.product_id IS NULL;
