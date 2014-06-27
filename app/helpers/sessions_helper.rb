module SessionsHelper
    def sign_in(user)
        remember_token = User.new_remember_token 
        # permanent == expires in 20 years
        cookies.permanent[:remember_token] = remember_token
        # save hashed cookie in DB
        user.update_attribute(:remember_token, User.digest(remember_token))
        self.current_user = user
    end
    # only assignement function operator to "save" current user
    def current_user=(user)
        @current_user = user
    end
    # used to retrieve the user according to the token
    # because stateless HTTP nature, we have to...
    def current_user
        remember_token = cookies[:remember_token]
        @current_user ||= User.find_by(remember_token: User.digest(remember_token))
    end 

    # is the user signed in ?
    def signed_in?
        !current_user.nil?
    end 


    def sign_out
        current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
        cookies.delete(:remember_token)
        self.current_user = nil

end
