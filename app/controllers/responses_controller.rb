class ResponsesController < ApplicationController
	before_action :set_up_survey
	def index
		@responses = current_user.responses
	end

	def new
		@response = current_user.responses.find_by_survey_id_and_user_id(@survey.id, current_user.id)
		@survey_questions = @survey.survey_questions.includes(:question)
		if @response.present?
			redirect_to survey_response_path(@survey, @response)
		else
			@response = current_user.responses.build
		end
	end

	def create
		@response = @survey.responses.create(user: current_user)
		params[:question].each do |key, val|
			@response.answers.create(question_id: key, answer: val.kind_of?(Array) ? val.join(",") : val)
		end
		respond_to do |format|
			flash[:notice] = "Thank you for participating in the survey!!!"
			format.html{redirect_to survey_response_path(@survey, @response)}
		end
	end

	def show
		@response = @survey.responses.find_by_id(params[:id])
		@answers = @response.answers
		@survey_questions = @survey.survey_questions.includes(:question).where(question_id: @answers.pluck(:question_id))
	end

	private
	def set_up_survey
		@survey = Survey.find_by_id(params[:survey_id])
	end

	def response_params
		params.permit!
	end

	def check_if_user_has_already_attempted
		@response = current_user.responses.find_by_survey_id(@survey.id)
		@response.present?
	end
end
