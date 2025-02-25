class Api::UserController < ApplicationController
  protect_from_forgery

  def signup
    name = params[:name]
    password = params[:password]
    password_check = params[:password_check]
    email = params[:email]
    twitter_oauth_token = params[:twitter_oauth_token]  

    ActiveRecord::Base.transaction do
      result = User.signup(
        name,
        password,
        password_check,
        email
      )

      if result then
        user = User.find_by(name: name)
          
        if user then
          result, access_token, refresh_token = user.signin(password)

          if !twitter_oauth_token.nil? and !twitter_oauth_token.empty? then
            # twitterでのOAuth認証の場合
            oauth = TwitterOauth.find_by(oauth_token: twitter_oauth_token)
            if oauth then
              twitter_info = UserTwitterInfomation.create(
                user: user,
                twitter_id: oauth.twitter_id
              )
              twitter_info.save!()
            end
          end
        end

        render :json => {
          'result': result,
          'name': name,
          'access_token': access_token.nil? ? '' : access_token.token,
          'access_token_expiration': access_token.nil? ? '' : access_token.expiration,
          'refresh_token': refresh_token.nil? ? '' : refresh_token.token,
          'refresh_token_expiration': refresh_token.nil? ? '' : refresh_token.expiration
        }
      else
        render :json => {
          'result': false
        }
      end
    end

    rescue => ex
      render :json => {
        'result': false
      }
  end

  def signin
    name_or_email = params[:name_or_email]
    password = params[:password]

    if name_or_email and name_or_email.include?('@') then
      user = User.find_by(email: name_or_email)
    else
      user = User.find_by(name: name_or_email)      
    end

    result = false
    if user then
      result, access_token, refresh_token = user.signin(password)
    end

    if result then
      result_json = {
        'result': result,
        'name': user.name,
        'access_token': access_token.nil? ? '' : access_token.token,
        'access_token_expiration': access_token.nil? ? '' : access_token.expiration,
        'refresh_token': refresh_token.nil? ? '' : refresh_token.token,
        'refresh_token_expiration': refresh_token.nil? ? '' : refresh_token.expiration
      }
    else
      result_json = {
        'result': result
      }
    end

    render :json => result_json
  end

  def signout    
    name = params[:name]
    user = User.find_by(name: name)

    logger.info('this is signout')
    authenticate_or_request_with_http_token do |token, options|
      logger.info('token is ' + token)
      if user && user.check_access_token(token) then
        user.signout()
        render :json => {
          'result': true
        }
      else
        render :json => {
          'result': false
        }, status: :unauthorized
      end
    end
  end

  def refresh
    name = params[:name]
    user = User.find_by(name: name)

    authenticate_or_request_with_http_token do |token, options|
      result = false
      access_token = nil
      refresh_token = nil

      if user then
        result, access_token, refresh_token = user.refresh(token)
      end

      if result then
        render :json => {
          'result': result,
          'name': name,
          'access_token': access_token.nil? ? '' : access_token.token,
          'access_token_expiration': access_token.nil? ? '' : access_token.expiration,
          'refresh_token': refresh_token.nil? ? '' : refresh_token.token,
          'refresh_token_expiration': refresh_token.nil? ? '' : refresh_token.expiration
        }
      else
        render :json => {
          'result': false
        }, status: :unauthorized
      end
    end
  end

  def namecheck
    name = params[:name]
    if name then
      ret = User.find_by(name: name)
      if ret then
        render :json => {
          'result': true,
          'is_duplicated': true
        }
      else
        render :json => {
          'result': true,
          'is_duplicated': false
        }
      end
    else
      render :json => {
        'result': false
      }, status: :bad_request
    end
  end


  def emailcheck
    email = params[:email]
    if email then
      ret = User.find_by(email: email)
      if ret then
        render :json => {
          'result': true,
          'is_duplicated': true
        }
      else
        render :json => {
          'result': true,
          'is_duplicated': false
        }
      end
    else
      render :json => {
        'result': false
      }, status: :bad_request
    end
  end

  def twitteroauth
    oauth_url, oauth_token, oauth_token_secret = TwitterOauth::request_token()

    oauth = TwitterOauth.create(
      oauth_token: oauth_token,
      oauth_token_secret: oauth_token_secret
    )
    oauth.save()

    render :json => {
      'result': true,
      'oauth_url': oauth_url
    }
  end

  def twitteroauth_callback
    oauth_token = params[:oauth_token]
    oauth_verifier = params[:oauth_verifier]

    if oauth_token.nil? or oauth_verifier.nil? then
      # スマートに開発環境と本番環境で切り分けたい。うまくいかん。
      if ENV["RAILS_ENV"] == 'production' then
        redirect_to 'https://kotobanote.jp/#/signup', status: 303
      else
        redirect_to 'http://localhost:8900/#/signup', status: 303
      end
    else
      oauth = TwitterOauth.find_by(oauth_token: oauth_token)
      if !oauth.nil? and oauth.set_profile(oauth_verifier) then
        # ユーザ情報の取得成功
        if UserTwitterInfomation.find_by(twitter_id: oauth.twitter_id) then
          # アカウントが存在する
          if ENV["RAILS_ENV"] == 'production' then
            redirect_to 'https://kotobanote.jp/#/signin?twitter_oauth_token=' + oauth_token, status: 303
          else
            redirect_to 'http://localhost:8900/#/signin?twitter_oauth_token=' + oauth_token, status: 303
          end
        else
          # アカウントが存在しない
          if ENV["RAILS_ENV"] == 'production' then
            redirect_to 'https://kotobanote.jp/#/twitteroauth?oauth_token=' + oauth_token, status: 303
          else
            redirect_to 'http://localhost:8900/#/twitteroauth?oauth_token=' + oauth_token, status: 303
          end
        end
      else
        # 失敗
        if ENV["RAILS_ENV"] == 'production' then
          redirect_to 'https://kotobanote.jp/#/signup', status: 303
        else
          redirect_to 'http://localhost:8900/#/signup', status: 303
        end
      end
    end
  end

  def twitteroauth_get_userinfo
    oauth_token = params[:oauth_token]

    if oauth_token.nil? or oauth_token.empty? then
      render :json => {
        'result': false
      }
    else
      oauth = TwitterOauth.find_by(oauth_token: oauth_token)
      if oauth.nil? then
        render :json => {
          'result': false
        }
      else
        render :json => {
          'result': true,
          'email': oauth.email,
          'screen_name': oauth.screen_name
        }
      end
    end
  end

  def twitter_signin
    oauth_token = params[:oauth_token]

    if oauth_token.nil? or oauth_token.empty? then
      # oauthが取得できなかった
      render :json => {
        'result': false
      }
    else
      # oauthが取得できた
      oauth = TwitterOauth.find_by(oauth_token: oauth_token)

      if oauth.nil? then
        # 認証失敗
        render :json => {
          'result': false
        }
      else
        # 認証成功
        twitter_info = UserTwitterInfomation.find_by(
          twitter_id: oauth.twitter_id
        )

        user = twitter_info.user
        
        result = false
        if user then
          result, access_token, refresh_token = user.force_signin()
        end

        if result then
          result_json = {
            'result': result,
            'name': user.name,
            'access_token': access_token.nil? ? '' : access_token.token,
            'access_token_expiration': access_token.nil? ? '' : access_token.expiration,
            'refresh_token': refresh_token.nil? ? '' : refresh_token.token,
            'refresh_token_expiration': refresh_token.nil? ? '' : refresh_token.expiration
          }
        else
          result_json = {
            'result': result
          }
        end
        render :json => result_json
      end
    end
  end
end
