require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest

  def setup
    @person = people(:rob)
    @other = people(:cg)
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

  test "should follow a user the standard way" do
    assert_difference '@person.following.count', 1 do
      post relationships_path, followed_id: @other.id
    end
  end

  test "should follow a user with Ajax" do
    assert_difference '@person.following.count', 1 do
      xhr :post, relationships_path, followed_id: @other.id
    end
  end

  test "should unfollow a user the standard way" do
    @person.follow(@other)
    relationship = @person.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@person.following.count', -1 do
      delete relationship_path(relationship)
    end
  end

  test "should unfollow a user with Ajax" do
    @person.follow(@other)
    relationship = @person.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@person.following.count', -1 do
      xhr :delete, relationship_path(relationship)
    end
  end
  
end
