class Option < ApplicationRecord
	validates :option_content, presence: true
end
