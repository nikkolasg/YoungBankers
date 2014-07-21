
FactoryGirl.define do
    sequence :email do |n|
        "didi#{n}@didine.com"
    end
    
    factory :user do
        #sequence(:fname) { |n| "Person#{n}"}
        fname "didine"
        lname "didine"
        email
        password "12345"
        password_confirmation "12345"
        enrol 1
        
        role "executive"
        link_fb "http://www.facebook.com/profile"
        display_private "true"
        hobbies "golf & fun"
        factory :admin do
            admin true
        end
    end
end
