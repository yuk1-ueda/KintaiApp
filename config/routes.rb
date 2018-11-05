Rails.application.routes.draw do
  get "timetable" => "timetables#index"
  get "new" => "timecards#new"
  
  get "login" => "users#login_form"
  post "users/create" => "users#create"
  get 'signup' => "users#new"
  
  post "login" => "users#login"
  get "login" => "users#login_form"
  post "logout" => "users#logout"

  post "timecards/create_start" => "timecards#create_start"
  post "timecards/create_end" => "timecards#create_end"
  post "csv_output" => "timetables#csv_output"

  get "/" => "home#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end