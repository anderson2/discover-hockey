require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @person = people(:rob)
    @post = @person.posts.build(content: "Here is a new post!")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.person_id = nil
    assert_not @post.valid?
  end
  
  test "content should be present " do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "content should be at most 2500 characters" do
    @post.content = "a" * 2501
    assert_not @post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal Post.first, posts(:most_recent)
  end
  
end
