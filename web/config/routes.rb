Rails.application.routes.draw do
  namespace :api do
    post 'user/create'
    post 'user/login'
    get 'user/logout'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
