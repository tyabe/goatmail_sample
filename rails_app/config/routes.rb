Rails.application.routes.draw do
  root to: 'messages#new'
  post '/' => 'messages#create'
  mount Goatmail::App, at: "/inbox" if Rails.env.development?
end
