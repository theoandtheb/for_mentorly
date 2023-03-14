Rails.application.routes.draw do
  root to: "users#new"
  resources :users
  get ':in_url' => 'goto#send_to'
end
