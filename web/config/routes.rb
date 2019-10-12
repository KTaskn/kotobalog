Rails.application.routes.draw do
  namespace :api do
    get 'status/check'
  end
  namespace :api do
    post 'user/signup'
    post 'user/signin'
    post 'user/signout'
  end
  namespace :api do
    post 'user/create'
    post 'user/login'
    post 'user/logout'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
