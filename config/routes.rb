Rails.application.routes.draw do
  
  root 'application#index'


  #----- angular non-static partials -----#

  get '/angular/:page' => 'angular#show'
  
  
  #----- All roads lead to app -----#

  get "*path" => "application#index"
end
