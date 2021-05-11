# frozen_string_literal: true

Rails.application.routes.draw do
  root    'static_p_age#home'
  get     '/home',      to: 'static_p_age#home'
  get     '/help',      to: 'static_p_age#help', as: 'helf'
  get     '/hello',     to: 'static_p_age#hello'
  get     '/about',     to: 'static_p_age#about'
  get     '/contact',   to: 'static_p_age#contact'
  get     '/signup',    to: 'users#new'
  get     '/login',     to: 'session#new'
  post    '/login',     to: 'session#create'
  delete  '/logout',    to: 'session#destroy'
  get 'auth/:provider/callback', to: 'session#create'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :microposts, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
end
