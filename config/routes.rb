Rails.application.routes.draw do
	root 'subscribers#index'
  post 'subscribers/sign_in'
  get 'subscribers/index'
	resources :orders, only: [:index]
	resources :dishes, only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
