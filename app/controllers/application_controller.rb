class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
 	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception

  	before_action :current_cart

  	private

  	def current_cart
  		if session[:cart_id]
    		cart = Cart.find_by(:id => session[:cart_id])
    		if cart.present?
      		@current_cart = cart
    		else
      		session[:cart_id] = nil
    		end
  		end

  		if session[:cart_id] == nil
    		@current_cart = Cart.create
    		session[:cart_id] = @current_cart.id
  		end

  		give_cart_to_real_user if @current_cart&.user_id.blank? && current_user.present? ## from guest user to real user only for starting phase one time

  		if current_user.present? && current_user.cart.present? && session[:cart_id].present?
  			current_user.cart.line_items << @current_cart.line_items
				@current_cart = current_user.cart
				session[:cart_id] = @current_cart.id
  		end
  	end

  	def give_cart_to_real_user
  		@current_cart.update(user_id: current_user.id)
  	end
end
