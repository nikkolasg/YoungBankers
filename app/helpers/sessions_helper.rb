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
        return nil unless remember_token = cookies[:remember_token] 
        @current_user ||= User.find_by(remember_token: User.digest(remember_token))
    end 

    def current_user?(user)
        user == current_user
    end
    # is the user signed in ?
    def signed_in?
        !current_user.nil?
    end 
    # verify sign & redirect later after login 
    def signed_in_user?
        unless signed_in?
            store_redirect_location
            redirect_to signin_path ,notice: "You are not logged in ... "
        end
    end
    
    def sign_out
        current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
        cookies.delete(:remember_token)
        self.current_user = nil
    end

    ## redirection helpers
    #call when you want redirection after an action (i.e. loggin)
    def redirect_back(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
    end

    def store_redirect_location(redirect=nil)
        session[:return_to] = (redirect if !redirect.nil?) || (request.url if request.get?)
    end

end
