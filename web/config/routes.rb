Rails.application.routes.draw do
  namespace :api do
    get 'timeline/get'
  end
  namespace :api do
    post 'sentence/note'
    post 'sentence/get'
    post 'sentence/getmine'
  end
  namespace :api do
    get 'status/check'
  end
  namespace :api do
    post 'user/signup'
    post 'user/signin'
    post 'user/signout'
    post 'user/refresh'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
