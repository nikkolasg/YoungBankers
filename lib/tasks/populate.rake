namespace :db do
    desc "Fill database with sample users"
    task populate: :environment do
        password = "12345"
        User.create!(fname:"admin",lname:"admin",email:"admin@admin.com",password:"admin",password_confirmation:"admin",admin:true)
        50.times do |n|
            fname = Faker::Name.first_name
            lname = Faker::Name.last_name
            email = Faker::Internet.email("#{n}")
            
            User.create!(fname: fname,lname: lname,  email:email,password: password, password_confirmation: password)
        end
    end
end
