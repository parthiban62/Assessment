class SurveyMailer < ApplicationMailer
	def share_survey(survey, email)
	    @survey = survey
	    mail to: email, subject: "Take Up the Survey"
  	end
end
