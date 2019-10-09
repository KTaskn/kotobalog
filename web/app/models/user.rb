class User < ApplicationRecord
    has_secure_password
    validates :name, uniqueness: true, presence: true, format: { 
        with: /\A[a-zA-Z0-9_]+\z/,
        maximum: 15
    }

    VALID_EMAIL_REGEX = URI::MailTo::EMAIL_REGEXP
    validates :email, uniqueness: true, presence: true, format: {
        with: VALID_EMAIL_REGEX,
        maximum: 255
    }

    def check_access_token(token_str)
        token = AccessToken.find_by(user: self)
        if token then
            return token.check(token_str)
        else
            return false
        end
            
    end

    def check_refresh_token(token_str)
        token = RefreshToken.find_by(user: self)
        if token then
            return token.check(token_str)
        else
            return false
        end
    end

    def login(password)
        if self.authenticate(password) then
            return true, AccessToken.refresh(self), RefreshToken.refresh(self)
        else
            return false, nil, nil
        end
    end

    def logout()
        access_token = AccessToken.find_by(user: self)
        access_token.remove()
        refresh_token = RefreshToken.find_by(user: self)
        refresh_token.remove()
    end
end
