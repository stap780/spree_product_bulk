Deface::Override.new(virtual_path: 'spree/admin/products/index',
    name: 'add_admin_products_table_header_checkbox_field',
    insert_top: "[data-hook='admin_products_index_headers']",
    partial: 'spree/admin/products/header_checkbox',
    original: 'eb9ecf7015fa51bb0adf7dafd7e6fdf1d652026d',
    disabled: false)

Deface::Override.new(virtual_path: 'spree/admin/products/index',
    name: 'add_admin_products_table_checkbox_fields',
    insert_top: "[data-hook='admin_products_index_rows']",
    partial: 'spree/admin/products/product_checkbox',
    original: 'eb9ecf7015fa51bb0adf7dafd7e6fdf1d652025d',
    disabled: false)


Deface::Override.new(virtual_path: 'spree/admin/shared/_content_header',
    name: 'add_admin_products_bulk_button',
    insert_before: "[data-hook='toolbar']",
    partial: 'spree/admin/products/bulk_button',
    original: 'eb9ecf7015fa51bb0adf7dafd7e6fdf1d652027d',
    disabled: false)