Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  # Defines the root path route ("/")
  root 'pages#splash_screen'

  #resources :pages, only %i[splash_screen]

  resources :groups, path: 'categories' do
    resources :expenses, path: 'transactions'
  end
end
