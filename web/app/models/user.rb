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
end
