Junglly::Application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: 'users/sessions'
  }

  root to: 'top#home'
  match '/teams/:id' => redirect("/%{id}"), constraints: { id: /\d+/ }
  match '/:id' => 'teams#show', constraints: { id: /\d+/ }
  resources :teams
end
