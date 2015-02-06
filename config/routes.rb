Rails.application.routes.draw do
  
  root 'application#index'


  #----- user api routes -----#
  post '/api/login_token' => 'users#login_token'
  post '/api/login_email' => 'users#login_email'
  post '/api/signup' => 'users#signup'
  get  '/api/logout' => 'users#logout'


  #----- battle api routes -----#
  get '/api/battle/:date' => 'battles#show'


  #----- county api routes -----#
  get  '/api/counties' => 'counties#index'


  #----- angular non-static partials -----#
  get '/angular/:page' => 'angular#show'
  
  
  #----- All roads lead to app -----#
  get "*path" => "application#index"

end
