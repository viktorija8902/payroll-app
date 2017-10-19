Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "time_report#index"
  post "/", to: "time_report#save_file"
end
