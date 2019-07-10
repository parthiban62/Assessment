class HomeController < ApplicationController
	def index
		@participated_surveys = current_user.responses
	end
end
