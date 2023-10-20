Deface::Override.new(virtual_path: 'spree/admin/variants/_form',
    name: 'add_admin_variants_form_barcode_field',
    insert_after: "[data-hook='sku']",
    partial: 'spree/admin/products/variant_barcode_field',
    original: 'eb9ecf7015fa51bb0adf7dafd7e6fdf1d652046d',
    disabled: false)

Deface::Override.new(virtual_path: 'spree/admin/products/_form',
    name: 'add_admin_products_form_barcode_field',
    insert_before: "[data-hook='admin_product_form_sku']",
    partial: 'spree/admin/products/barcode_field',
    original: 'eb9ecf7015fa51bb0adf7dafd7e6fdf1d652036d',
    disabled: false)

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
    partial: 'spree/admin/products/bulk_buttons',
    original: 'eb9ecf7015fa51bb0adf7dafd7e6fdf1d652027d',
    disabled: false)
