class User < ApplicationRecord
    validates:name, presence: true,length: {minimum:1 , maximum:50 }
    before_save { self.email = self.email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates:email, presence: true,
        length: {minimum:5, maximum:50},
            format: { with: VALID_EMAIL_REGEX },
                uniqueness: true
    validates :password, length: { minimum: 6 }
    has_secure_password
    validates :password, presence: true, length: {minimum:6}
end
