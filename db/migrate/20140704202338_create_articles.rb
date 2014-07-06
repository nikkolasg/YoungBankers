class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.string :image
      t.integer :user_id , index: true

      t.timestamps
    end
    add_index :articles , :created_at # comes from timestamps
  end
end
