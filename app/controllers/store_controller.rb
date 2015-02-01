class StoreController < ApplicationController
  def index
  	@products = Product.find_products_for_sale
  	@cart = find_cart
  end
  
  def add_to_cart
	  logger.debug "debug----------begin"
  	product = Product.find(params[:id])
  	@cart = find_cart
  	@current_item = @cart.add_product(product)
  	#redirect_to_index nil
	  logger.debug "debug----------end"
  	
  	respond_to do |format|
  		format.html {redirect_to_index nil}
  		format.js
  	end
 	rescue ActiveRecord::RecordNotFound
 		logger.error("Attempt to access invalid product #{params[:id]}")
 		#redirect_to_index "Invalid product"
 		respond_to do |format|
 			format.html {redirect_to_index "Invalid product"}
 			format.js
 		end
  end
  
  def empty_cart
  	session[:cart] = nil
  	redirect_to_index nil
  end
  
  private
  def find_cart
  	session[:cart] ||= Cart.new
  end
  
  def redirect_to_index(msg)
  	flash[:notice] = msg if msg
  	redirect_to :action=>'index'
  end
end
