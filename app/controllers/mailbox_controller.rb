class MailboxController < ApplicationController
    before_action :signed_in_user?
    helper_method :mailbox, :conversation

    def create 
        participants_email = conversation_params(:participants).split(',')
        participants_users = Users.find_by(email: participants_email).all

        subject = message_params(:subject)
        body = message_params(:body)

        conv = current_user.send_message(participants_users,
                                         subject,
                                         body).conversation
        redirect_to conversation_path(conv)
    end

    def reply
        current_user.reply_to_conversation(conversation, *message_params(:body,:subject))
        redirect_to conversation_path(conversation)
    end
        private

        def mailbox
            @mailbox ||= current_user.mailbox
        end 

        def conversation
            @conv ||= mailbox.conversations.find(params[:id])
        end

        def conversation_params(*keys)
            fetch_params(:conversation,*keys)
        end
        def message_params(*keys)
            fetch_params(:message,*keys)
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
