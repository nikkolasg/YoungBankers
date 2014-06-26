module SessionsHelper
    def sign_in(user)
        user.remember_token!
        cookies[:remember_token] = { :values => user.remember_token,
                                     :expires => 2.days.from_now.utc }
        self.current_user = user}
    end

end
