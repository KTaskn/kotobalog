Rails.application.routes.draw do
  namespace :api do
    get 'timeline/get'

    get 'sentence/get'
    get 'sentence/getmine'
    get 'sentence/islike'
    post 'sentence/note'
    post 'sentence/like'

    get 'status/check'
    
    get 'user/namecheck'
    get 'user/emailcheck'
    get 'user/twitteroauth'
    get 'user/twitteroauth_callback'
    get 'user/twitteroauth_get_userinfo'
    post 'user/signup'
    post 'user/signin'
    post 'user/signout'
    post 'user/refresh'
    post 'user/twitter_signin'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
