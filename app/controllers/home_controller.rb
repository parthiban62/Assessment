class HomeController < ApplicationController
	def index
		@surveys = current_user.is_admin? ? Survey.all : current_user.responses
	end
end
