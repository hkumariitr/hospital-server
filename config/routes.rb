Rails.application.routes.draw do
  namespace :api do
    post '/login', to: 'authentication#login'
    post '/register', to: 'authentication#register'
    resources :patients, only: [:index, :show, :create, :update, :destroy]
    get '/patient_stats', to: 'patients#stats'
  end
end
