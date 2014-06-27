class SessionsController < ApplicationController
    before_create :create_remember_token
    def new
        render 'new'
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase
        if user && user.authenticate(params[:session][:password]
           sign_in user
           redirect_to user
       else
           flash[:error] = "Invalid credentials..."
           render 'new'
    end

    def destroy
        sign_out
        redirect_to 'users'
    end
end
