# frozen_string_literal: true

Rails.application.routes.draw do
  root    'posts#index'
  resources :posts
  resources :posts do
    resources :votes, only: [:create, :destroy]
    resources :comments,only: [:create, :destroy]
  end
  resources :comments do
    resources :votes, only: [:create, :destroy]
  end
  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show

  
end
