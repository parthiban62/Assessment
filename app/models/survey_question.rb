class SurveyQuestion < ApplicationRecord
	belongs_to :survey
	belongs_to :question
	default_scope { order(created_at: :asc) }
end
