require 'test_helper'

class PeopleIndexTest < ActionDispatch::IntegrationTest

  def setup
    @person = people(:rob)
  end

  test "index including pagination" do
    log_in_as(@person)
    get people_path
    assert_template 'people/index'
    assert_select 'div.pagination'

    Person.paginate(page: 1).each do |person|
      # assert_select 'a[href=?]', person_path(person), text: person.name
    end
  end

end
