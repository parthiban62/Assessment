class SurveysController < ApplicationController

	before_action :set_question_types
	before_action :set_survey, except: [:index,:new,:create,:participants]

	before_action :check_if_user_is_admin, only: [:participants]

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
	end

	def update
		if @survey.update_attributes(survey_params)
			flash[:notice] = 'survey created successfully'
			redirect_to surveys_path
		else
			@errors = @survey.errors
			render :edit
		end
	end

	def show
		@question = Question.new
	end

	def destroy
		if @survey.destroy
			flash[:notice] = "Survey deleted successfully"
		else
			flash[:notice] = "Unable to delete survey"
		end
		redirect_to surveys_path
	end

	def participants
		@survey = Survey.find_by_id(params[:id])
		@responses = @survey.responses
	end

	private
	def survey_params
		params.require(:survey).permit(:id, :name,questions_attributes: [:id, :question_no, :question_type_id, :question_content, :_destroy, options_attributes: [:id, :option_content, :_destroy]])
	end

	def set_question_types
		@question_types = QuestionType.all
	end

	def set_survey
		@survey = @user.surveys.find_by_id(params[:id])
	end

	def check_if_user_is_admin
		redirect_to root_path unless current_user.is_admin?
	end
end
