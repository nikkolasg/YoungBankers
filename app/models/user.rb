class User < ActiveRecord::Base
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
    validates :lname ,:fname , presence: true, 
                                length: { maximum: 50}
    before_save { self.email = email.downcase }
    
    validates :password, length: { minimum: 5 , maximum: 50 }
    
    has_secure_password #handle double confirmation & presence
    

    before_create :create_remember_token
    ## static methods  
    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end
    def User.digest(token)
        Digest::SHA1.hexdigest(token)
    end

    private 
        
        def create_remember_token
           self.remember_token = User.digest(User.new_remember_token) 
        end
end
