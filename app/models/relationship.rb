class Relationship < ActiveRecord::Base

  belongs_to :follower, class_name: "Person"
  belongs_to :followed, class_name: "Person"

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  
end
