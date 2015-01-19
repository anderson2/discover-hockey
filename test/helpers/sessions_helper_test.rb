require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @person = people(:rob)
    remember(@person)
    
  end

  test "current_person returns right user when session is nil" do
    assert_equal @person, current_person
    assert is_logged_in?
    
  end

  test "current_person returns nil when remember digest is wrong" do
    @person.update_attribute(:remember_digest, Person.digest(Person.new_token))
    assert_nil current_person
    
  end
  
end