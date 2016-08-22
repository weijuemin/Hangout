Rails.application.routes.draw do
  # Users
  root 'users#index'

  get "/users/register" => "users#register"

  post "/users/new" => "users#create"

  post "/users/login" => "users#login"

  get "/users/logout" => "users#logout"

  get '/users/show' => 'users#show'

  get '/users/edit' => 'users#edit'

  patch "/users/edit" => "users#update" 

  # Events
  get "/events" => "events#index"

  get "/events/:evt_id" => "events#show"

  get "/events/:evt_id/edit" => "events#edit"

  post "/events" => "events#create"

  patch "/events/:evt_id" => "events#update"

  delete "/events/:evt_id" => "events#destroy"

  patch "/events/:evt_id/unjoin" => "events#unjoin"

  patch "/events/:evt_id/join" => "events#join"

  post "/comment/:evt_id" => "events#comment"

  delete "/comment/delete/:cmt_id" => "events#delete_cmt"

end
