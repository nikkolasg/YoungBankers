class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :password_digest, :string
      
      t.column :lname, :string , :limit => 50
      t.column :fname, :string, :limit => 50
      t.column :email, :string, :limit => 100 
      t.column :gender, :integer # 1 = male 2 = female
      t.column :enrol, :integer # 1 = individual 2= organization
       
      t.column :role, :string # executive , chief , etc
      t.column :profile_picture
      t.column :link_fb, :string
      t.column :link_li, :string 
      t.column :link_twitter, :string
      t.column :link_gplus, :string
      # Private informations
      t.column :display_private, :boolean, default: true
      t.column :hobbies, :string, limit: 200
      t.column :city, :string, :limit => 50
      t.column :code, :integer
      t.column :country, :string, :limit => 30
      t.column :region, :string, :limit => 40
      t.column :phone, :string , :limit => 14
      t.column :fax, :string, :limit => 14
      
      # authentification related
      t.column :last_login_ip, :string 
      # TODO MORE 

      t.timestamps
    end
  end
end
