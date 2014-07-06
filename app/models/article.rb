class Article < ActiveRecord::Base
    belongs_to :user, dependent: :destroy
    default_scope -> { order('created_at DESC')} # scope, array will come by date
    validates :user_id , presence: true
    validates :title, presence: true, length: { maximum: 60 }
    validates :content, presence: true , length: {maximum: 1000, minimum: 50 }

end
