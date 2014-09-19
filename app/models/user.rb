class User < ActiveRecord::Base
    belongs_to :organization
    accepts_nested_attributes_for :organization

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PHONE_REGEX = /\A\+?[0-9]{3}-?[0-9]{6,12}\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX},
        uniqueness: { case_sensitive: false }
    validates :lname ,:fname , presence: true, 
        length: { maximum: 50}
    before_save { self.email = email.downcase }

    validates :password, length: { minimum: 5 , maximum: 50 }

    validates :gender, presence:true
    validates :role, presence:true
    validates :country, :city, presence: true
    validates :organization, presence:true
    # validates :phone , format: { with: VALID_PHONE_REGEX }

    has_secure_password #handle double confirmation & presence   

    before_create :create_remember_token

    # PROFILE PIC
    mount_uploader :avatar, AvatarUploader

    # SEARCH
    searchkick



    ## static methods  
    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end
    def User.digest(token)
        Digest::SHA1.hexdigest(token)
    end
    def org_name
        (org = self.organization) && org.name
    end        
    def org_name=(name)
        if org = Organization.find_by(name:name)
            self.organization = org
        else
            org = Organization.create(name:name)
        end
    end

    private 
    def create_remember_token
        self.remember_token = User.digest(User.new_remember_token) 
    end

end
