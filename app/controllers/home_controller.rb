class HomeController < ApplicationController
	def index
		session[:current] = "home"
		@surveys = current_user.is_admin? ? Survey.all : current_user.responses
	end
end
