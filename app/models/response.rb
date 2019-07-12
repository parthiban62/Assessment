class Response < ApplicationRecord
	belongs_to :user
	belongs_to :survey
	has_many :answers, dependent: :destroy
	has_many :questions
end
