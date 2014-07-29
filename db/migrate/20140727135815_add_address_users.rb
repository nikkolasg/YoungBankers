class AddAddressUsers < ActiveRecord::Migration
  def change
      add_column :users, :address, :string
      add_column :users, :code_post, :string
  end
end
