class SurveysController < ApplicationController

	before_action :set_question_types
	before_action :set_side_bar_tab
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
			@survey.add_questions_for_user
			@survey.auto_generate_question_numbers
			flash[:notice] = 'survey created successfully'
			redirect_to surveys_path
		else
			@errors = @survey.errors
			render :edit
		end
	end

	def show
		@question = Question.new
		@questions = @user.questions
		@survey_questions = @survey.survey_questions.includes(:question)
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

	def add_questions
		@question = Question.find_by_id(params[:question_id])
		@question_added_already = false
		if @survey.questions.where(id: @question.id).present?
			@question_added_already = true
		else
			@survey.questions << @question
		end
		respond_to :js
	end

	private
	def survey_params
		params.require(:survey).permit(:id, :name,questions_attributes: [:id, :question_no, :question_type_id, :question_content, :_destroy, options_attributes: [:id, :option_content, :_destroy],users_attributes: [:id]])
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

	def set_side_bar_tab
		session[:current] = "surveys"
	end
end
