class UserController < ApplicationController
    def list
        @users = User.find(:all)
    end
    def show
        @user = User.find(params[:id])
    end
    def new
        @user = User.new 
        ##creating a new user
        # can also retrive external info such as all type of organization, etc.
    end
    def create
        @user = User.new(params[:user]) # :user object built from user inputform
        if @user.save
            redirect_to :action => 'show', :id => @user
        else
            render  :action => 'new'
        end
    end
    def edit ## action to edit an user, to render edit options
        @user = User.find(params[:id])
    end
    def update ## action to save updated info about user
        @user = User.find(params[:id])
        if @user.update_attributes(params[:user])
            redirect_to :action => 'show', :id => @user
        else
            render  :action => 'edit'
        end
    end 
    def delete
        User.find(params[:id]).destroy
        redirect_to :action => 'list'
    end
end
