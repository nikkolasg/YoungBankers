
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
        gender 1 
        country "France"
        city "Paris"
        role "executive"
        link_fb "http://www.facebook.com/profile/nikko"
        link_li "http://www.facebook.com/profile/nikko"
        display_private "true"
        hobbies "golf & fun"
        factory :admin do
            admin true
        end
        organization
    end

    factory :organization do
        name "World Bank"
    end
end
