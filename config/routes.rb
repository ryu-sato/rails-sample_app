Rails.application.routes.draw do
  # GET /
  root 'static_pages#home'

  # GET /static_pages/*
  get '/home',    to: 'static_pages#home'
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'

  # RESOURCES /users
  resources :users
end
