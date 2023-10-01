Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    
    # post 'products/bulk_delete', to: 'products#bulk_delete'
    post 'products/delete_selected', to: 'products#delete_selected'
    post 'products/edit_products_taxon', to: 'products#edit_products_taxon'
    put 'products/update_products_taxon', to: 'products#update_products_taxon'

  end
end
