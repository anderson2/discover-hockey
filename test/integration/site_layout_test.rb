require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "layout links" do
    get root_path
    
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2

    assert_select "a[href=?]", about_path
    assert_select "a[href=https://github.com/anderson2]", contact_path
    
    assert_select "a[href=?]", signup_path, count: 3

    
  end
  
end
