require 'rails_helper'

describe "Static Pages" do
  
    base_title = "Young Bankers Connect"   
    describe "Home page" do
        it "should have the content 'HOME'" do
            visit '/home'
            expect(page).to have_content('HOME')
        end
        it "should have title '#{base_title}' " do
            visit '/home'
            expect(page).to have_title(base_title)
        end
  end

    describe "About page" do
        it "should have the content 'benefit'" do
            visit '/about'
            expect(page).to have_content('benefit')
        end
        it "should have title '#{base_title} | About'" do
            visit '/about'
            expect(page).to have_title("#{base_title} | About")
        end
    end
end
