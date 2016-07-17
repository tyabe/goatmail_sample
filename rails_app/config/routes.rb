Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'messages#new'
  post '/' => 'messages#create'
  mount Goatmail::App, at: "/inbox" if Rails.env.development?
end
