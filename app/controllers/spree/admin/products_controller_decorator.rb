module Spree
  module Admin
    module ProductsControllerDecorator
      require 'csv'

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
          @products = Spree::Product.where(id: params[:product_ids].split(','))
          respond_to do |format|
            format.html
            format.js
          end
        else
          flash[:notice] = 'select products'
          redirect_to collection_url
        end
      end

      def update_products_taxon #PUT
        @products = Spree::Product.find(params[:product_ids]) # .reject!(&:blank?)
        taxon_ids = params[:taxon_ids].reject!(&:blank?)
        # puts 'taxon_ids - ' + taxon_ids.to_s
        @products.each do |pr|
          pr.update!(taxon_ids: taxon_ids)
        end
        flash[:notice] = 'products taxon updated'
        redirect_to collection_url
      end

      def bulk_set_active #PUT
        if params[:product_ids].present?
          @products = Spree::Product.where(id: params[:product_ids].split(','))
          @products.update_all(status: 'active')
          flash[:success] = 'products status updated'
          respond_with(@products) do |format|
            format.html { redirect_to collection_url }
            format.js { render layout: false }
          end
        else
          flash[:notice] = 'select products'
          redirect_to collection_url
        end
      end

      def bulk_export
        if params[:product_ids].present?
          @products = Spree::Product.where(id: params[:product_ids].split(','))
          var_ids = []
          @products.each do |product|
            vars = Spree::Variant.where(product_id: product.id).pluck(:id)
            vars.each do |var|
              var_ids.push(var)
            end
          end
          @variants = Spree::Variant.where(id: var_ids).order(:id)
        else
          @variants = Spree::Variant.all.order(:id)
        end

        # header1 = ['Var id','is master?','Name','Sku','Desc','Price','Quantity','Barcode']
        header1 = Spree::Product.column_names.map{|p| "Product:"+p}
        header2 = Spree::Variant.column_names.map{|p| "Variant:"+p}+["Variant:price","Variant:quantity","Variant:images"]
        header3 = Spree::Property.all.present? ? Spree::Property.all.map{|p| "Property:"+p.name} : []
        header4 = Spree::OptionType.all.present? ? Spree::OptionType.all.map{|p| "OptionType:"+p.name} : []
        @full_header = header1.uniq+header2.uniq+header3.uniq+header4.uniq


        attrs_for_sheet = []
        @variants.each do |variant|
          puts "variant id --- "+variant.id.to_s
          product = variant.product ? variant.product : Product.new
          attr_for_sheet_product = JSON.parse( product.to_json ).transform_keys{ |key| "Product:"+key.to_s }
          # => {"Product:id"=>233,"Product:name"=>nil,"Product:description"=>nil}
          attr_for_sheet_variant = JSON.parse( variant.to_json ).transform_keys{ |key| "Variant:"+key.to_s }
          attr_for_sheet_prop = Hash.new
          if variant.product && variant.product.product_properties
            variant.product.product_properties.pluck(:property_id, :value).each do |prop|
              prop_name = Spree::Property.find_by_id(prop[0]).name
              prop_value = prop[1]
              attr_for_sheet_prop["Property:"+prop_name] = prop_value
            end
          end
          attr_for_sheet_option = Hash.new
          if variant.option_values
            variant.option_values.each do |option_value|
              opt_name = option_value.option_type.name
              opt_value = option_value.name
              attr_for_sheet_option["OptionType:"+opt_name] = opt_value
            end
          end
          quantity =  variant.stock_items.present? ? variant.stock_items.first.count_on_hand : ''
          images = []
          variant.images.map do |image|
            images.push(main_app.cdn_image_url(image.attachment))
          end
          image_urls = images.present? ? images.join(' ') : ' '
          
          attr_for_sheet_variant_extra = {"Variant:price" => variant.price.to_i, "Variant:quantity" => quantity, "Variant:images" => image_urls }
          attrs_for_sheet.push( attr_for_sheet_product.merge(attr_for_sheet_variant).merge(attr_for_sheet_variant_extra).merge(attr_for_sheet_prop).merge(attr_for_sheet_option) )
        end

        @attrs_for_sheet = attrs_for_sheet.flatten
        
        respond_to do |format|
          format.html
          format.csv do
            response.headers['Content-Type'] = 'text/csv'
            response.headers['Content-Disposition'] = "attachment; filename=products_bulk_export.csv"
          end
        end
        
      end

    end
  end
end
  
Spree::Admin::ProductsController.prepend(Spree::Admin::ProductsControllerDecorator)
