require 'spec_helper'
require 'rails_helper'
describe 'Users pages' do
    subject {page}

    describe "index" do

        describe  "should list users" do
            before do
                FactoryGirl.create(:user,email:"user2@example.com")
                FactoryGirl.create(:user,email:"user3@example.com")
                valid_signin FactoryGirl.create(:user)
                visit users_path
            end

            it { should have_content ("User List") }
        end
        #describe "pagination" do
        #   users = []
        #  before(:all) { 10.times {users << FactoryGirl.create(:user)}}
        # after(:all) { users.each { |u|  u.destroy }}
        #it { should have_selector('div.pagination') }
        # end

        describe "Delete link" do
            it { should_not have_link("delete") }
            describe "as admin user" do
                let(:admin) { FactoryGirl.create(:admin) }
                before do 
                    populate_users
                    visit signin_path
                    valid_signin admin 
                    visit users_path
                end

                it { should have_link("delete", href: user_path(User.second))}
                it "should be able to delete another user" do
                    expect do
                        click_on("delete", match: :first)
                    end.to change(User, :count).by(-1)
                end
                describe "should not see a delete link for himself" do
                    it { should_not have_link("delete", href: user_path(admin) )}
                end
            end
        end
    end

    describe "profile page" do
        let(:user) { FactoryGirl.create(:user) }
        before do
            visit root_path
            valid_signin(user) 
        end
        it { should have_content("User Profile") }
        it { should have_link("Edit Profile") }

    end
    describe "signup page" do
        before { visit signup_path }
        it { should have_content("new user") }


        describe "Signup process" do

            before { visit signup_path }
            let(:submit) { "Submit" }

            describe " with invalid data" do
                it "should not create user" do
                    expect { click_button submit }.not_to  change(User, :count)
                end
            end

            describe "with valid data" do
                before do
                    fill_in "user_fname",   with: "elodou"
                    fill_in "user_lname",    with: "elodou"
                    fill_in "user_email" ,       with: "elodou@elodou.com"
                    fill_in "user_password",     with: "12345"
                    fill_in "user_password_confirmation", with: "12345"
                    choose 'user_enrol_1'
                end
                it "should create user" do
                    expect { click_button submit }.to change(User, :count).by(1)
                end
            end
        end
    end

    describe "Edit" do
        let(:user) { FactoryGirl.create(:user) }
        before do
            visit root_path
            valid_signin(user)
            click_on "Edit Profile"
        end 
        it { should have_content("Edit your profile") }

        describe "with invalid info" do
            before { click_on "Submit" }
            it {should have_selector("div.alert.alert-danger") }
        end

        describe "with valid information" do
            let(:new_email) { "new@example.com" }
            before do
                fill_in "user_email",            with: new_email
                fill_in "user_password",         with: user.password
                fill_in "user_password_confirmation", with: user.password
                click_button "Submit"
            end

            it { should have_selector('div.alert.alert-success') }
            it { should have_link('Sign out', href: signout_path) }
            specify { expect(user.reload.email).to eq new_email }
        end
    end


end
