class QuestionsController < ApplicationController
	before_action :set_survey

	def new
		@question = @survey.questions.build
	end

	def create
		@question = @survey.questions.build(question_params)
		respond_to do |format|
			if @question.save
				@survey.questions << @question
				format.html{ redirect_to survey_path(@survey)}
				format.js
			else
				format.html{ render :new}
				format.js
			end
		end
	end

	def edit
		@question_types = QuestionType.all
		@question = @survey.questions.find_by_id(params[:id])
	end

	def update
		@question = @survey.questions.find_by_id(params[:id])
		respond_to do |format|
			if @question.update_attributes(question_params)
				flash[:notice] = 'Question updated successfully'
				format.html{ redirect_to survey_path(@survey)}
				format.js
			else
				format.html{ render :new}
				format.js
			end
		end
	end


	def destroy
		@question = @survey.questions.find_by_id(params[:id])
		respond_to do |format|
			if @question.destroy
				format.html{ redirect_to survey_path(@survey)}
				format.js
			else
				format.html{}
			end
		end
	end

	private

	def question_params
		params.require(:question).permit(:id, :question_no, :question_type_id, :question_content, :_destroy, options_attributes: [:id, :option_content, :_destroy])
	end

	def set_survey
		@survey = @user.surveys.find_by_id(params[:survey_id])
	end
end
