class Response < ApplicationRecord
	belongs_to :user
	belongs_to :survey
	has_many :answers
	has_many :questions
end
