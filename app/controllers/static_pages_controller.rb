class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @post = current_person.posts.build 
      @feed_items = current_person.feed.paginate(page: params[:page])
      
    end
    
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
