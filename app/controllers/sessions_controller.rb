class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    person = Person.find_by(email: params[:session][:email].downcase)
    
    if person && person.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page
      log_in person
      
      # Enable persistent sessions if 'Stay signed in' box is checked
      params[:session][:remember_me] == '1' ? remember(person) : forget(person)
      
      # redirect_to person
      redirect_back_or person
      
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
      
    end
  
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
    
  end
  
end
