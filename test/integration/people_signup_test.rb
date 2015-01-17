require 'test_helper'

class PeopleSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Person.count' do
      post people_path, person: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'people/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'Person.count', 1 do
      post_via_redirect people_path, person: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'people/show'
  end  
  
end
