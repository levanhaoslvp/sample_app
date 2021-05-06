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
  delete  '/login',     to: 'session#destroy'
  get 'sessions/new'
  resources :users
  resources :account_activations, only: [:edit]
end
