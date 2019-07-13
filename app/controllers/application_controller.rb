class ApplicationController < ActionController::Base

	protect_from_forgery

	before_action :authenticate_user!
	before_action :set_current_user
	before_action :configure_permitted_parameters, if: :devise_controller?


	def set_current_user
		@user = current_user
	end

	protected
	  def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
	    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :email, :password, :current_password)}
	  end
end
