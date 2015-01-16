require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @person = Person.new( name:   "Example Person", 
                          email:  "exampleperson@example.com")
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
  
end
