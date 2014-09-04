require 'rails_helper'

RSpec.describe Organization, :type => :model do

    let(:user) { FactoryGirl.create(:user) }

    before do
        @organization = Organization.create(name:"Global Bank")
    end

    subject { @organization}

    it { should respond_to(:name) }


    it { should be_valid }

    
end
