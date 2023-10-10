Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    
    # post 'products/bulk_delete', to: 'products#bulk_delete'
    post 'products/delete_selected', to: 'products#delete_selected'
    post 'products/edit_products_taxon', to: 'products#edit_products_taxon'
    put 'products/update_products_taxon', to: 'products#update_products_taxon'
    put 'products/bulk_set_active', to: 'products#bulk_set_active'
    post 'products/bulk_export', to: 'products#bulk_export', defaults: { format: :csv }
    
  end
end
