# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_role = Role.find_or_create_by(name: "Admin")
site_user = Role.find_or_create_by(name: "SiteUser")

input_type = QuestionType.find_or_create_by(name: "Text", descriptive: true)
text_area_type = QuestionType.find_or_create_by(name: "TextArea", descriptive: true)
listing_type = QuestionType.find_or_create_by(name: "Listing")
single_choice = QuestionType.find_or_create_by(name: "Single Choice")
multiple_choice = QuestionType.find_or_create_by(name: "Multiple Choice")



user_admin = User.new(firstname: "Site", lastname: "Admin", email: "admin@survey.com", password: "test123", password_confirmation: "test123")
user_admin.role = admin_role
user_admin.save



site_user1 = User.new(firstname: "Christoper", lastname: "Nolan", email: "siteuser1@survey.com", password: "test123", password_confirmation: "test123")
site_user1.role = site_user
site_user1.save


site_user2 = User.new(firstname: "James", lastname: "John", email: "siteuser2@survey.com", password: "test123", password_confirmation: "test123")
site_user2.role = site_user
site_user2.save


site_user3 = User.new(firstname: "Henry", lastname: "Mark", email: "siteuser3@survey.com", password: "test123", password_confirmation: "test123")
site_user3.role = site_user
site_user3.save


site_user4 = User.new(firstname: "Jacky", lastname: "Johnson", email: "siteuser4@survey.com", password: "test123", password_confirmation: "test123")
site_user4.role = site_user
site_user4.save






survey1 = site_user1.surveys.create(name: "About our Product")

survey_question_1 = Question.new(question_no: 1,question_content: "Have you ever purchased our product?")
survey_question_1.question_type = single_choice
survey_question_1.options.build(option_content: "Yes")
survey_question_1.options.build(option_content: "No")
survey_question_1.save
survey1.questions << survey_question_1


survey_question_2 = Question.new(question_no: 1,question_content: "How would you came to know about our product")
survey_question_2.question_type = multiple_choice
survey_question_2.options.build(option_content: "Newspaper")
survey_question_2.options.build(option_content: "Internet")
survey_question_2.options.build(option_content: "Television")
survey_question_2.options.build(option_content: "Advertising Agency")
survey_question_2.options.build(option_content: "On Your Own")
survey_question_2.save
survey1.questions << survey_question_2


survey_question_3 = Question.new(question_no: 1,question_content: "How likely are you to use our service?")
survey_question_3.question_type = listing_type
survey_question_3.options.build(option_content: "Extremly Unsatisfied")
survey_question_3.options.build(option_content: "Unsatisfied")
survey_question_3.options.build(option_content: "Neutral")
survey_question_3.options.build(option_content: "Satisfied")
survey_question_3.options.build(option_content: "Extremly Satisfied")
survey_question_3.save
survey1.questions << survey_question_3



survey_question_3 = Question.new(question_no: 1,question_content: "Tell us about your nature of job?")
survey_question_3.question_type = text_area_type
survey_question_3.save
survey1.questions << survey_question_3



survey_question_4 = Question.new(question_no: 1,question_content: "Would You recommend this product to your friends?")
survey_question_4.question_type = single_choice
survey_question_4.options.build(option_content: "Yes")
survey_question_4.options.build(option_content: "No")
survey_question_4.save
survey1.questions << survey_question_4


survey_question_5 = Question.new(question_no: 1,question_content: "How much time do you spend in Internet per day?")
survey_question_5.question_type = input_type
survey_question_5.save
survey1.questions << survey_question_5



survey1.shares.create(email: site_user2.email)
survey1.shares.create(email: site_user3.email)
survey1.shares.create(email: site_user4.email)