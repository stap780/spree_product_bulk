module Spree
  module Admin
    module ProductsControllerDecorator

      def delete_selected
        puts 'here delete_selected params => '+params.to_s
        # puts 'params[:product_ids] - ' + params[:product_ids].to_s
        products = Spree::Product.where(id: params[:product_ids].split(',')) # friendly - только в товарах и наверно в taxon
        # puts "##########"
        # puts products.size
        # puts "##########"
        if  products.size > 0
          products.each do |product|
            product.destroy
          end
          flash[:success] = Spree.t('notice_messages.product_deleted')
          redirect_to collection_url
        else
          flash[:notice] = 'select products'
          redirect_to collection_url
        end
    end

      def edit_products_taxon #GET
        # puts params[:product_ids].present?
        if params[:product_ids].present?
          @products = ::Spree::Product.where(id: params[:product_ids])
          respond_to do |format|
            format.html
            format.js
          end
        else
          redirect_to collection_url
        end
      end

      def update_products_taxon #PUT
        @products = ::Spree::Product.find(params[:product_ids]) # .reject!(&:blank?)
        taxon_ids = params[:taxon_ids].reject!(&:blank?)
        puts 'taxon_ids - ' + taxon_ids.to_s
        @products.each do |pr|
          new_taxons = []
          taxon_ids.each do |tx|
            puts tx.to_i
            new_taxons = !pr.taxon_ids.include?(tx.to_i) ? pr.taxon_ids.push(tx.to_i) : pr.taxon_ids
          end
          puts 'new_taxons - ' + new_taxons.uniq.to_s
          pr.update!(taxon_ids: new_taxons.uniq)
        end
        flash[:notice] = 'products taxon обновлены'
        redirect_to collection_url
      end

    end
  end
end
  
Spree::Admin::ProductsController.prepend(Spree::Admin::ProductsControllerDecorator)
