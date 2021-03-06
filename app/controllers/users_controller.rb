class UsersController < ApplicationController
    ## has to be signed in for all action regarding users ...
    before_action :signed_in_user?, except: [:new, :create] #, only: [:index,:edit,:update]
    before_action :correct_user? ,   only: [:edit,:update]
    before_action :admin_user? ,     only: [:destroy,:accept,:export_excel] 
    
    

    def index
        if params[:query].present?
            @users = User.search(params[:query], page: params[:page])
        else
            if current_user.admin?
                @users = User.paginate(page: params[:page], :per_page => 10)
            else
                @users = User.where(:pending => false).paginate(page: params[:page], :per_page => 10) ## only see the accepted members by normal users
            end
        end
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
        render 'edit'
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
        u = User.find(params[:id])
        u.destroy
        flash[:danger] = "User #{u.email} have been deleted"
        redirect_to :action => 'index'
    end

    ## Accept a user profile, i.e. set pending attribute to false
    def accept
       @user = User.find(params[:id])
       @user.pending = false
       if @user.update_attribute(:pending,false)
           flash[:success] = "Account accepted !"
       else
           flash[:warning] = "Account has not been accepted.#{@user.errors.inspect}"
       end
       redirect_to :action => 'index'
    end

    def export_excel
       headers['Content-Type'] = "application/vnd.ms-excel" 
       @users = User.where(:pending => true)
       render :layout => false
    end

    private

   

    def correct_user?
        @user = User.find(params[:id])
        unless current_user?(@user)
            flash[:danger] = "You are not authorized to go on this page"
            redirect_to root_path
        end
    end
    # Only admin can do the delete request (agaisnt malicious query)
    def admin_user?
        unless (current_user && current_user.admin?)
            flash[:danger] = "You are not an admin. You can not do that"
            redirect_to :action => 'index'
        end
    end
    def user_params
        params.require(:user).permit(:lname,:email,:fname,:password,:password_confirmation,
                                     :gender,:role,:display_private,:link_li,:country,:city,:phone,:hobbies,
                                    :avatar,:org_name, :organization_attributes => [ :id, :name])
    end

         

end
