class RelationshipsController < ApplicationController

  before_action :logged_in_person

  def create
    @person = Person.find(params[:followed_id])
    current_person.follow(@person)
    respond_to do |format|
      format.html { redirect_to @person }
      format.js
    end
  end

  def destroy
    @person = Relationship.find(params[:id]).followed
    current_person.unfollow(@person)
    respond_to do |format|
      format.html { redirect_to @person }
      format.js
    end
  end

end
