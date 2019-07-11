class Question < ApplicationRecord
	has_many :survey_questions
	has_many :surveys, through: :survey_questions
	belongs_to :question_type
	has_many :options, dependent: :destroy
	has_many :user_questions
	has_many :users, through: :user_questions
	accepts_nested_attributes_for :options, allow_destroy: true,  reject_if: proc { |attr| attr['option_content'].blank?}
	accepts_nested_attributes_for :users

	default_scope { order(created_at: :asc) }

	validates :question_content, presence: true
	def is_subjective?
		question_type.name.eql?("Text") || question_type.name.eql?("TextArea")
	end

	def is_text_type?
		question_type.name.eql?("Text")
	end
end
