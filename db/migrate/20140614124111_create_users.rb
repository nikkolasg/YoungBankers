class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :hash, :string, :null =>false
      t.column :lname, :string , :limit => 50, :null =>false
      t.column :fname, :string, :limit => 50
      t.column :email, :string, :limit => 100, :null =>false
      t.column :gender, :integer # 1 = male 2 = female
      t.column :type, :integer , :null => false # 1 = individual 2= organization
      t.column :city, :string, :limit => 50
      t.column :code, :integer
      t.column :country, :string, :limit => 30
      t.column :region, :string, :limit => 40
      t.column :phone, :string , :limit => 14
      t.column :fax, :string, :limit => 14
      t.timestamps
    end
  end
end
