class UsersController < ApplicationController
    before_action :signed_in_user? ,      only: [:index,:edit,:update]
    before_action :correct_user? ,   only: [:edit,:update]
    before_action :admin_user? , only: :destroy 

    def index
        @users = User.paginate(page: params[:page], :per_page => 4)
    end
    
    def show
        @user = User.find(params[:id])
        @article = @user.articles.paginate(page: params[:page])
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
            flash[:error] = "You are not logged in Or are not the user you want to modify"
            redirect_to :action => 'index'
        end
    end
    def update ## action to save updated info about user
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Update successful!" 
            redirect_to  @user # can pass object
            # due to natural routing for restful ressources
        else
            render  :action => 'edit'
        end
    end 
    def destroy
        User.find(params[:id]).destroy
        redirect_to :action => 'index'
    end
    private
        def correct_user?
            @user = User.find(params[:id])
            unless current_user?(@user)
                flash[:error] = "You are not authorized to go on this page"
                redirect_to :action => 'index' 
            end
        end
        # Only admin can do the delete request (agaisnt malicious query)
        def admin_user?
            unless (current_user && current_user.admin?)
                flash[:error] = "You are not an admin to delete user"
                redirect_to :action => 'index'
            end
        end
        def user_params
        ##TODO 
            params.require(:user).permit(:lname,:email,:fname,:password,:password_confirmation,:enrol)
        end

end
