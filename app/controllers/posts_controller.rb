class PostsController < ApplicationController

  before_action :logged_in_person, only: [:create, :destroy]
  before_action :correct_person, only: :destroy

  def create
    @post = current_person.posts.build(post_params)
    if @post.save
      flash[:success] = "New post created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
    
  end


  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
    
  end



  private
  
    def post_params
      params.require(:post).permit(:content, :picture)
    end
    
    def correct_person 
      @post = current_person.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
      
    end
    
    
end