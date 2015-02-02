require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @person = Person.new( name:   "Example Person", 
                          email:  "exampleperson@example.com",
                          password: "foobar",
                          password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @person.valid?
  end
 
  test "name should be present" do
    @person.name = "     "
    assert_not @person.valid?
  end
 
  test "email should be present" do
    @person.email = "     "
    assert_not @person.valid?
  end

  test "name should not be too long" do
    @person.name = "a" * 51
    assert_not @person.valid?
  end
  
  test "email should not be too long" do
    @person.email = "a" * 101
    assert_not @person.valid?
  end
  
  test "email validation should accept valid email addresses" do
    email_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
  
    email_addresses.each do |email_address|
      @person.email = email_address
      puts email_address
      assert @person.valid?, "#{ email_address.inspect } should be invalid"
    end
  end

  test "email validation should reject invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
  
    invalid_addresses.each do |invalid_address|
      @person.email = invalid_address
      puts invalid_address
      assert_not @person.valid?, "#{ invalid_address.inspect } should be valid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @person.dup
    duplicate_user.email = @person.email.upcase
    @person.save
    assert_not duplicate_user.valid?
  end
  
  test "password should have a minimum length" do
    @person.password = @person.password_confirmation = "a" * 5
    assert_not @person.valid?
  end

  test "authenticated? should return false for a person with nil digest" do
    assert_not @person.authenticated?('')
  end
  
  test "associated posts should be destroyed" do
    @person.save
    @person.posts.create!(content: "Lorem ipsum")
    assert_difference 'Post.count', -1 do
      @person.destroy
    end
  end  
  
  test "should follow and unfollow a user" do
    rob = people(:rob)
    cg  = people(:cg)
    assert_not rob.following?(cg)
    rob.follow(cg)
    assert rob.following?(cg)
    assert cg.followers.include?(rob)
    rob.unfollow(cg)
    assert_not rob.following?(cg)
  end

  test "feed should have the right posts" do
    rob   = people(:rob)
    cg    = people(:cg)
    jane  = people(:jane)
    # Posts from followed user
    jane.posts.each do |post_following|
      assert rob.feed.include?(post_following)
    end
    # Posts from self
    rob.posts.each do |post_self|
      assert rob.feed.include?(post_self)
    end
    # Posts from unfollowed user
    cg.posts.each do |post_unfollowed|
      assert_not rob.feed.include?(post_unfollowed)
    end
  end
  
end







