class Post < ActiveRecord::Base

  belongs_to :person
  default_scope -> { order(created_at: :desc) }
  
  validates :person_id, presence: true
  validates :content, presence: true, length: { maximum: 2500 }  

end
