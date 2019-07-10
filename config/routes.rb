Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  resources :surveys do
  	member do
  		get :participants
      post :add_questions
  	end
    resources :shares
  	resources :questions
  	resources :responses
  end
end
