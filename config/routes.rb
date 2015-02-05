Rails.application.routes.draw do
  
  root 'application#index'


  #----- user api routes -----#
  post '/api/login_token' => 'users#login_token'
  post '/api/login_email' => 'users#login_email'
  post '/api/signup' => 'users#signup'


  #----- angular non-static partials -----#
  get '/angular/:page' => 'angular#show'
  
  
  #----- All roads lead to app -----#
  get "*path" => "application#index"

end
