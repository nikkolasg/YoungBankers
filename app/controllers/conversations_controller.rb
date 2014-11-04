class ConversationsController < ApplicationController
    before_action :signed_in_user?
    helper_method :mailbox, :conversation

    def index
        @conversations = mailbox.conversations
        @user = current_user
    end
    
    def show
        
    end
    
    def create 
        participants_email = params[:participants].split(',')
        participants_users = User::where(email: participants_email).all

        subject = params[:subject]
        body = params[:body]
        flash[:alert] =  "subject null" unless subject
        flash[:alert] = "body null" unless body
        flash[:alert] =  "no participants" unless (participants_users && participants_users.size > 0)
        conv = current_user.send_message(participants_users, 
                                         subject,
                                         body).conversation
        flash[:notice]  = " Message sent !"
        redirect_to '/mailbox'
    end

    def reply
        current_user.reply_to_conversation(conversation, params(:body,:subject))
        redirect_to conversation_path(conversation)
    end

    def trash
        conversation.move_to_trash(current_user)
        redirect_to :conversations
    end
    def untrash
        conversation.untrash(current_user)
        redirect_to :conversations
    end
    private
    def mailbox
        @mailbox ||= current_user.mailbox
    end 

    def conversation
        @conv ||= mailbox.conversations.find(params[:id])
    end

    def fetch_params(key, *subkeys)
        params[key].instance_eval do
            case subkeys.size
            when 0 then self
            when 1 then self[subkeys.first]
            else subkeys.map{|k| self[k] }
            end
        end
    end

end
