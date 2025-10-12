Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
  root 'resources#index'
  
  # 1. MOVE STATIC ROUTE HERE (Must be first)
  get 'resources/browse', to: 'resources#browse', as: 'browse_resources'

  # 2. Dynamic resources block comes second
  resources :resources, only: [:create, :new, :destroy, :edit, :update, :index, :show]
  
  # ... rest of your routes (createaccount, signup, signin, etc.)
  resources :createaccount, only: [:new, :create], path: 'createaccount'
  get  'signup', to: 'users#new',    as: 'sign_up'
  post 'signup', to: 'users#create'

  get  '/signin', to: 'signin#new', as: 'sign_in'
  post '/signin', to: 'signin#create'
  delete '/signout', to: 'signin#destroy', as: 'sign_out'
  get 'teacheraccount', to: 'teacheraccount#index', as: 'teacher_account'
  get 'studentaccount', to: 'studentaccount#index', as: 'student_account'
# get 'resources/edit', to: 'resources#edit', as: 'edit_resource'#

resources :study_groups
end
