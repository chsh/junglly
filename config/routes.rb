Junglly::Application.routes.draw do
  root to: 'top#home'
  match '/teams/:id' => redirect("/%{id}"), constraints: { id: /\d+/ }
  match '/:id' => 'teams#show', constraints: { id: /\d+/ }
  resources :teams
end
