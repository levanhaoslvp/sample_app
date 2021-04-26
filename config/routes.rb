Rails.application.routes.draw do
  root 'static_p_age#home'
  get 'static_p_age/home'
  get 'static_p_age/help'
end
