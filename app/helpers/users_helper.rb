module UsersHelper
    def gravatar_for(user)
        grav_id = Digest::MD5::hexdigest(user.email.downcase)
        grav_url =  "https://secure.gravatar.com/avatar/#{grav_id}"
        image_tag(grav_url, alt: "image", class: "profile_pic")
    end

    def title_for(user)
        case user.gender
        when 0
            "Mr. "
        when 1
            "Mrs. "
        when 2
            "Mlle "
        else
            ""
        end
    end
    def gender_for(user)
       case user.gender
       when 0
          "male"
       when 1,2
          "female"
       end
    end 
    
    def user_name(user)
        user.fname.capitalize + " " + user.lname.capitalize
    end
   

end
