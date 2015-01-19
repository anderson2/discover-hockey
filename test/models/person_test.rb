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

  test "authenticated? should return false for a user with nil digest" do
    assert_not @person.authenticated?('')
  end
  
end







