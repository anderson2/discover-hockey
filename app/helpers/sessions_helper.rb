module SessionsHelper
  
  # Log in the user
  def log_in(person)
    session[:person_id] = person.id
    
  end

  # Return the current logged-in user (if any).
  def current_person
    @current_person ||= Person.find_by(id: session[:person_id])
  
  end

  # Return true if the user is logged in, false otherwise.
  def logged_in?
    !current_person.nil?
    
  end

  # Log out the current user.
  def log_out
    session.delete(:person_id)
    @current_person = nil
    
  end
  
end
