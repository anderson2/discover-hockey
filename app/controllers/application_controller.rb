class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  
  include SessionsHelper



  private
  
    # Confirms a logged-in user.
    def logged_in_person
      unless logged_in?
        store_location
        flash[:danger] = "Please sign in to continue"
        redirect_to login_url
        
      end
    end
  
end
