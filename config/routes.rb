Rails.application.routes.draw do
  
  root 'application#index'


  #----- user api routes -----#
  get '/api/login_token' => 'users#login_token'
  post '/api/login_email' => 'users#login_email'
  post '/api/signup' => 'users#signup'
  get  '/api/logout' => 'users#logout'


  #----- battle api routes -----#
  get '/api/battles/:year/:month' => 'battles#show'
  get '/api/battles/winners' => 'battles#winners'
  post '/api/battles' => 'battles#create'
  post '/api/battles/upvote' => 'battles#upvote'
  post '/api/battles/nominate' => 'battles#nominate'
  post '/api/battles/addtrash' => 'battles#add_trash'


  #----- county api routes -----#
  get  '/api/counties' => 'counties#index'


  #----- angular non-static partials -----#
  get '/angular/:page' => 'angular#show'
  
  
  #----- All roads lead to app -----#
  get "*path" => "application#index"

end
