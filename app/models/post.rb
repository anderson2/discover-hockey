class Post < ActiveRecord::Base

  belongs_to :person
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  
  validates :person_id, presence: true
  validates :content, presence: true, length: { maximum: 2500 }  

  validate :picture_size
  
  
  
  private
  
    # Validate file size constraint for uploaded image
    def picture_size
      if picture.size > 700.kilobytes
        errors.add(:picture, "should be less than 700KB")
      end
      
    end
    
  
end
