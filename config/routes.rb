Rails.application.routes.draw do
  resources :exercise_entries
  resources :intake_entries
  # TODO this should be renamed to fitness_entries
  resources :body_entries
  resources :diaries
  get 'app/dashboard'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
end
