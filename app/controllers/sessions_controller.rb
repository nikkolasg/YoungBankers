class SessionsController < ApplicationController
    def new
        render 'new'
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
           sign_in user
           redirect_back user # redirect back or to user 
       else
           flash[:error] = "Invalid credentials..."
           render 'new'
       end
    end

    def destroy
        sign_out
        redirect_to root_path
    end
end
