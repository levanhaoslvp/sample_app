# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root    'static_p_age#home'
  get     '/home', to: 'static_p_age#home'
  resources :microposts, only: %i[create destroy]
end
