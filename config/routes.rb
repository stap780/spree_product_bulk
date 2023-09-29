Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    
    post 'products/bulk_delete', to: 'products#bulk_delete'

  end
end
