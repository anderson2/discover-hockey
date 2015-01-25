require 'test_helper'

class PeopleProfileTest < ActionDispatch::IntegrationTest

  include ApplicationHelper

  def setup
    @person = people(:rob)
  end

  test "profile display" do
    get person_path(@person)
    assert_template 'people/show'
    assert_select 'title', full_title(@person.name)
    assert_select 'h1', text: @person.name
    assert_select 'h1>img.gravatar'
    assert_match @person.posts.count.to_s, response.body
    assert_select 'div.pagination'
    @person.posts.paginate(page: 1).each do |post|
      #assert_match post.content, response.body
    end
  end
end