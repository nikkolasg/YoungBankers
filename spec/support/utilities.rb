include ApplicationHelper
# find the form and fill it and submit it
def valid_signin(user,opt={})
    if opt[:no_capybara]
        remember_token = User.new_remember_token
        cookies[:remember_token] = remember_token
        user.update_attribute(:remember_token, User.digest(remember_token))
    else
        visit signin_path
        ## login window in the navbar
        fill_in "Email" , with: user.email        
        fill_in "Password", with: user.password
        #page.save_screenshot("#{Rails.root.join('tmp')}/screenshot.png")
        click_on "Login"
    end
end

def populate_users(n=30)
    n.times { FactoryGirl.create(:user) }
end

