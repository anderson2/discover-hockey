require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest

  def setup
    @person = people(:rob)
    log_in_as(@person)
  end

  test "following page" do
    get following_person_path(@person)
    assert_not @person.following.empty?
    assert_match @person.following.count.to_s, response.body
    @person.following.each do |person|
      assert_select "a[href=?]", person_path(person)
    end
  end

  test "followers page" do
    get followers_person_path(@person)
    assert_not @person.followers.empty?
    assert_match @person.followers.count.to_s, response.body
    @person.followers.each do |person|
      assert_select "a[href=?]", person_path(person)
    end
  end
  
end
