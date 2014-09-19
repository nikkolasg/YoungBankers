class Organization < ActiveRecord::Base

  has_many :users  
   
  validates_presence_of :name

  searchkick text_start: [:name]  

end
