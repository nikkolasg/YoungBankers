module UsersHelper
    def gravatar_for(user)
        grav_id = Digest::MD5::hexdigest(user.email.downcase)
        grav_url =  "https://secure.gravatar.com/avatar/#{grav_id}"
        image_tag(grav_url, alt: "image", class: "profile_pic")
    end



end
