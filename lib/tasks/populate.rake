namespace :db do
    desc "Fill database with sample users"
    task populate: :environment do

        
        password = "12345"
        20.times do |n|
            fname = Faker::Name.first_name
            lname = Faker::Name.last_name
            email = Faker::Internet.email("#{n}")
            city = Faker::Address.city
            country = Faker::Address.country
            address = Faker::Address.street_address
            org = 1
            role = "business manager"
            cp = Faker::Address.zip
            User.create!(fname: fname,lname: lname,  gender:0,email:email,password: password, password_confirmation: password,
                        city: city,country: country, address: address, organization_id: org, code_post: cp,role: role)
        end
    end
end
