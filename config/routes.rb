Junglly::Application.routes.draw do
  root to: 'top#home'
  match '/:id' => 'teams#show', constraints: { id: /\d+/ }
  resources :teams
end
