class SurveyMailer < ApplicationMailer
	def share_survey(survey, email_ids)
    @survey = survey

    mail(:to => email_ids.join(","),
         :subject => "Take Up the Survey",
         :from => 'test@test.com')
  end
end
