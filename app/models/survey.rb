class Survey < ApplicationRecord
	belongs_to :user
	has_many :survey_questions, dependent: :destroy
	has_many :questions, through: :survey_questions
	has_many :responses, dependent: :destroy
	has_many :shares
	accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: proc { |attr| attr['question_content'].blank?}

	validates :name, presence: true

	default_scope { order(created_at: :asc) }

	def auto_generate_question_numbers
		self.survey_questions.each_with_index do |survey_question,index|
			survey_question.update_column("question_no", index+=1)
		end
	end

	def add_questions_for_user(user)
		self.survey_questions.each do |survey_question|
			user.questions << survey_question.question unless user.questions.find_by_id(survey_question.question_id).present?
		end
	end
	
end
