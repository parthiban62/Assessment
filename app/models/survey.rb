class Survey < ApplicationRecord
	belongs_to :user
	has_many :survey_questions, dependent: :destroy
	has_many :questions, through: :survey_questions
	has_many :responses
	has_many :shares
	accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: proc { |attr| attr['question_content'].blank?}

	validates :name, presence: true

	default_scope { order(created_at: :asc) }
	
end
