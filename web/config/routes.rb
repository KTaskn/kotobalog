Rails.application.routes.draw do
  namespace :api do
    get 'timeline/get'

    post 'sentence/note'
    post 'sentence/get'
    post 'sentence/getmine'
    post 'sentence/like'
    get 'sentence/islike'

    get 'status/check'
    
    post 'user/signup'
    post 'user/signin'
    post 'user/signout'
    post 'user/refresh'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
