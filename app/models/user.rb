# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    before_validation :ensure_session_token

    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest ,presence: true
    validates :password, length: {minimum: 6}, allow_nil: true

    attr_reader :password

    def self.find_by_credentials(email, password)
        @user = User.find_by(email: email)
        if @user && @user.is_password?(password)
            return @user
        else 
            nil
        end 
    end 

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end 

    def generate_session_token
        SecureRandom::urlsafe_base64
    end 

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(@password)
    end 

    def ensure_session_token
        self.session_token ||= generate_session_token
    end 

    def reset_session_token
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end 
end

#FIGVAPER
