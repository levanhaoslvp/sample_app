Rails.application.routes.draw do
  root 'static_p_age#home'
  get '/home', to: 'static_p_age#home'
  get '/help', to: 'static_p_age#help' , as: 'helf'
  get '/hello', to: 'static_p_age#hello'
  get '/about', to: 'static_p_age#about'
  get '/contact', to: 'static_p_age#contact'
  get '/signup', to: 'user#new'
end
