class Person < ActiveRecord::Base
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  has_many :posts, dependent: :destroy

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :following, through: :active_relationships, source: :followed
  
                                  
  attr_accessor :remember_token
  
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum:50 }
  validates :email, presence: true, length: { maximum:100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true                


  # Return the hash digest of the given string
  def Person.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Return a random token
  def Person.new_token
    SecureRandom.urlsafe_base64
  end
 
  # Remember user in the database for use in persistent sessions
  def remember
    self.remember_token = Person.new_token
    update_attribute(:remember_digest, Person.digest(remember_token))
  end

  # Return true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)

  end


  # Forget user to enable logout of session
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  
  def feed
    Post.where("person_id = ?", id)
  end
  

  # Follows a hockey player or another user
  def follow(other_person)
    active_relationships.create(followed_id: other_person.id)
  end

  # Unfollows a hockey player or another user
  def unfollow(other_person)
    active_relationships.find_by(followed_id: other_person.id).destroy
  end

  # Returns true if the current user is following the hockey player or user
  def following?(other_person)
    following.include?(other_person)
  end

  
end
