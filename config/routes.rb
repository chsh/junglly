Junglly::Application.routes.draw do
  resources :teams

  root to: 'top#home'
end
