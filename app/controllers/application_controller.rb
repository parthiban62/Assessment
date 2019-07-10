class ApplicationController < ActionController::Base

	protect_from_forgery

	before_action :authenticate_user!
	before_action :set_current_user

	def set_current_user
		@user = current_user
	end
end
