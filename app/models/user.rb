class User < ApplicationRecord
    attr_accessor :remember_token
    has_secure_password
    

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true
    has_many :user_times, dependent: :destroy
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
     
    
    def authenticated?(remember_token)
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end


    def remember
        remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

   def forget
      update_attribute(:remember_digest, nil)
   end

end
