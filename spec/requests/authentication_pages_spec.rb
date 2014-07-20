require 'spec_helper'

describe 'Authorization' do

    subject {page}

    describe "signin page" do
        before { visit signin_path }

        it { should have_content("Sign in") }
    end

    describe "sign in process" do

        before { visit signin_path }

        describe "with invalid credentials" do
            before { click_on("Signin") }

            it { should have_content("Invalid") }

            describe "after visiting other pages" do
                before { visit root_path }
                it { should_not have_selector('div.alert.alert-danger') }
            end
        end
        describe "with valid credentials" do
            let(:user) { FactoryGirl.create(:user) } 
            before do
                valid_signin(user) 
            end
            it { should have_link("Sign out") }

            describe "followed by signout" do
                before { click_on "Sign out" }
                it { should have_link("Sign in") }
            end
        end
    end

    describe "authorization control" do

        describe "to user controller" do

            let(:user) { FactoryGirl.create(:user) }

            describe "for non signed in user" do

                describe "access user index" do

                    before{ visit users_path }
                    it { should have_content("Sign In") }
                end
                describe "access to edit page" do
                    before { visit edit_user_path(user) }
                    it { should have_content("Sign In") }
                end

                describe "submit update action" do
                    before { patch user_path(user) }
                    specify { expect(response).to redirect_to(signin_path) }
                end

                describe "request User#destroy with DELETE request" do
                    before { delete user_path(user) }
                    specify  { expect(response).to redirect_to(signin_path) }
                end
            end

            describe "for wrong user" do
                let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@user.com") }    

                ## here directly submit request instead of capybara
                before { valid_signin(user, no_capybara: true) }

                describe "request User#edit  with GET request" do
                    before { get edit_user_path(wrong_user) }
                    specify { expect(response).to redirect_to root_path }
                end

                describe "request User#update with Patch request" do
                    before { patch user_path(wrong_user) }
                    specify { expect(response).to redirect_to root_path }
                end

                describe "request User#destroy with DELETE request" do
                    before { delete user_path(wrong_user) }
                    specify { expect(response).to redirect_to(users_path) }
                end
            end

                
        end


    end
end
