Rails.application.routes.draw do
  get 'static_p_age/home'
  get 'static_p_age/help'
  root 'application#hello'
end
