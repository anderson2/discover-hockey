class RelationshipsController < ApplicationController

  before_action :logged_in_person

  def create
    person = Person.find(params[:followed_id])
    current_person.follow(person)
    redirect_to person
  end

  def destroy
    person = Relationship.find(params[:id]).followed
    current_person.unfollow(person)
    redirect_to person
  end

end
