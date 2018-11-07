Rails.application.routes.draw do
  get "/" => "home#redirect"

  get 'signup' => "users#new"
  post "users/create" => "users#create"

  get "login" => "users#login_form"
  post "login" => "users#login"

  post "logout" => "users#logout"
 
  get "new" => "timecards#new"
  post "timecards/create_start" => "timecards#create_start"
  post "timecards/create_end" => "timecards#create_end"

  get "timetable" => "timetables#index"
  get "/timetable/search" => "timetables#search"
  post "/timetable/search_table" => "timetables#search_table"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end