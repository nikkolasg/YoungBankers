require 'rails_helper'

describe "Static Pages" do
  
    
    describe "Home page" do
        it "should have the content 'HOME'" do
            visit '/home'
            expect(page).to have_content('HOME')
        end
        it "should have title 'Young Bankers | Home'" do
            visit '/home'
            expect(page).to have_title('Young Bankers | Home')
        end
  end

    describe "About page" do
        it "should have the content 'benefit'" do
            visit '/about'
            expect(page).to have_content('benefit')
        end
        it "should have title 'Young Bankers | About'" do
            visit '/about'
            expect(page).to have_title('Young Bankers | About')
        end
    end
end
