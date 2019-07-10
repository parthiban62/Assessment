require 'sendgrid-ruby'
class SurveyMailer < ApplicationMailer
	include SendGrid
	def share_survey(survey, sender_email)
		from = Email.new(email: 'test@example.com')
		subject = 'Take Up the Survey'
		to = Email.new(email: sender_email)
		content = Content.new(type: 'text/html', value: "<p>Hello</p><p>Greeting from survey App, we want you to take the below survey. Please click on the link below to continue,https://assessment-test-survey.herokuapp.com/surveys/#{survey.id}/responses/new</p>")
		mail = Mail.new(from, subject, to, content)
		sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
		response = sg.client.mail._('send').post(request_body: mail.to_json)
  	end
end
