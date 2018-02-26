Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :quizzes, only: [:index, :show, :create, :update], defaults: {format: 'json'}
  resources :graded_quizzes, only: [:create, :show], defaults: {format: "json"}
end
