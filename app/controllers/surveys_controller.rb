class SurveysController < ApplicationController

	before_action :set_question_types

	def index
		@surveys = current_user.is_admin? ? Survey.all : @user.surveys
	end

	def new
		@survey = @user.surveys.build
		@survey.questions.build
	end

	def create
		@survey = @user.surveys.build(survey_params)
		if @survey.save
			flash[:notice] = 'survey created successfully'
			redirect_to surveys_path
		else
			@errors = @survey.errors
			@survey = @user.surveys.build(survey_params)
			render :new
		end
	end

	def edit
		@survey = @user.surveys.find_by_id(params[:id])
	end

	def update
		@survey = @user.surveys.find_by_id(params[:id])
		if @survey.update_attributes(survey_params)
			flash[:notice] = 'survey created successfully'
			redirect_to surveys_path
		else
			@errors = @survey.errors
			render :edit
		end
	end

	def show
		@survey = @user.surveys.find_by_id(params[:id])
		@question = Question.new
	end

	def destroy
		@survey = @user.surveys.find_by_id(params[:id])
		if @survey.destroy
			flash[:notice] = "Survey deleted successfully"
		else
			flash[:notice] = "Unable to delete survey"
		end
		redirect_to surveys_path
	end

	def share_survey
		@survey = @user.surveys.find_by_id(params[:id])
	end

	def survey_via_email
		SurveyMailer.share_surveyparams[:email]
	end

	def participants
	end

	private
	def survey_params
		params.require(:survey).permit(:id, :name,questions_attributes: [:id, :question_no, :question_type_id, :question_content, :_destroy, options_attributes: [:id, :option_content, :_destroy]])
	end

	def set_question_types
		@question_types = QuestionType.all
	end
end
