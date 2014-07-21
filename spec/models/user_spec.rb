require 'rails_helper'
require 'spec_helper'

describe User do
    before { @user = User.new(fname:"elo",lname:"elo",email:"elo@elo.com",enrol:1,password:"12345",password_confirmation:"12345" )}

    subject { @user }

    it { should respond_to :fname }
    it { should respond_to :email }
    it { should respond_to :password_digest }
    it {should respond_to :password }
    it { should respond_to :password_confirmation }
    it { should respond_to :remember_token }
    it { should respond_to :role }
    it { should respond_to :link_li }
    it { should respond_to :display_private }
    it { should respond_to :hobbies }
    it { should be_valid }
    
    describe "remember_token" do
        before {@user.save }
        its(:remember_token) {
            should_not be_blank
        }
    end

    describe "when email is empty" do
        before { @user.email = " " }
        it { should_not be_valid }
    end

    describe "when email format is invalid" do
        it "should be invalid" do
            addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
            addresses.each do |invalid_address|
                @user.email = invalid_address
                expect(@user).not_to be_valid
            end
        end
    end

    describe "when email format is valid" do
        it "should be valid" do
            addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
            addresses.each do |valid_address|
                @user.email = valid_address
                expect(@user).to be_valid
            end
        end
    end
    describe "when email already taken" do
        before do
            duplicate_user = @user.dup
            duplicate_user.save
        end

        it { should_not be_valid }
    end

    describe "when fname is empty" do
        before { @user.fname = "" }
        it { should_not be_valid }
    end

    describe "when lname is empty" do
        before { @user.lname = " " }
        it { should_not be_valid }
    end
    
    describe "when password is not present" do
        before do 
             @user = User.new(fname:"elo",lname:"elo",email:"elo@elo.com",enrol:1,password:" ",password_confirmation:"12345" )
        end
        it { should_not be_valid }
    end

    describe "when confirmation is not present" do
        before { @user.password_confirmation ="" }
        it { should_not be_valid }
    end

    describe "when password mismatch" do
        before { @user.password_confirmation="123456789" }
        it { should_not be_valid }
    end

    describe "return value of authenticate" do
        before { @user.save }
        let(:final_user) { User.find_by(email: @user.email) }

        describe "with valid password" do
            it { should eq final_user.authenticate(@user.password) }
        end

        describe "with invalid password" do
            let(:invalid_user) { final_user.authenticate("mismatch") }
            it { should_not eq invalid_user } # @user != invalid_user
           #  specify { expect( invalid_user).to be_false} DOESNT work because invalid_user is FalseClass (no false? meth)
        end
    end
end
