class PostsController < ApplicationController

  before_action :logged_in_person, only: [:create, :destroy]

  def create
    @post = current_person.posts.build(post_params)
    if @post.save
      flash[:success] = "New post created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
    
  end


  def destroy
  end



  private
  
    def post_params
      params.require(:post).permit(:content)
    end
    
end