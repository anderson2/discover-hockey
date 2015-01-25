class StaticPagesController < ApplicationController

  def home
    @post = current_person.posts.build if logged_in?
    
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
