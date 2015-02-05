Rails.application.routes.draw do
  
  root 'application#index'


  #----- user api routes -----#
  post '/api/get-user' => 'users#get_user'
  post '/api/login' => 'users#login'
  post '/api/signup' => 'users#signup'


  #----- angular non-static partials -----#
  get '/angular/:page' => 'angular#show'
  
  
  #----- All roads lead to app -----#
  get "*path" => "application#index"

end
