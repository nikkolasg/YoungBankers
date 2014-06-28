class UsersController < ApplicationController
    def index
        list
    end
    def list
        @users = User.all
    end
    def show
        @user = User.find(params[:id])
    end
    def new
        @user = User.new 
    end

    def create
        @user = User.new(user_params) # :user object built from user inputform
        if @user.save
            # signin the user (token etc)
            sign_in @user
            flash[:success] = "Registration sucessfull !"
            redirect_to @user 
        else
            render 'new'
        end
    end
    def edit ## action to edit an user, to render edit options
        @user = User.find(params[:id])
        ##TEST
        if signed_in?
            render 'edit'
        else
            flash [:error] = "You are not logged in Or are not the user you want to modify"
            redirect_to :action => 'index'
        end
    end
    def update ## action to save updated info about user
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
            redirect_to :action => 'show', :id => @user # can pass object
            # due to natural routing for restful ressources
        else
            render  :action => 'edit'
        end
    end 
    def delete
        User.find(params[:id]).destroy
        redirect_to :action => 'list'
    end
    private
        def user_params
            ##TODO 
            params.require(:user).permit(:lname,:email,:fname,:password,:pasword_confirmation,:enrol)
        end

end
