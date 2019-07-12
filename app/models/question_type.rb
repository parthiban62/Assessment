class QuestionType < ApplicationRecord
	has_many :questions

	def self.types
		order('created_at asc')
	end

end
