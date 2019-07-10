class SharesController < ApplicationController
	before_action :set_survey

	def index
		@shares = @survey.shares
	end

	def new
		@share = @survey.shares.build
	end

	def create
		@share = @survey.shares.build(share_params)
		if @survey.shares.where(email: share_params[:email]).present?
			flash[:error] = "you have already shared this survey to this email id"
			render :new
		else
			if @share.save
				flash[:notice] = "survey shared successfully"
				SurveyMailer.share_survey(@survey, @share.email).deliver!
				redirect_to survey_shares_path(@survey)
			else
				render :new
			end
		end
	end

	def edit
		@share = @survey.shares.find_by_id(params[:id])
	end

	def update
		@share = @survey.shares.find_by_id(params[:id])
		if @survey.shares.where(email: share_params[:email]).present?
			flash[:error] = "you have already shared this survey to this email id"
			render :new
		else
			if @share.update_attributes(share_params)
				flash[:notice] = "survey updated successfully"
				SurveyMailer.share_survey(@survey, @share.email).deliver_later
				redirect_to survey_shares_path(@survey)
			else
				render :new
			end
		end
	end

	private
	def set_survey
		@survey = @user.surveys.find_by_id(params[:survey_id])
	end

	def share_params
		params.require(:share).permit(:id, :email)
	end
end
