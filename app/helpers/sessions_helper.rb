module SessionsHelper
  
  # Log in the user (person)
  def log_in(person)
    session[:person_id] = person.id
    
  end

  # Remember a user in a persistent session.
  def remember(person)
    person.remember
    cookies.permanent.signed[:person_id] = person.id
    cookies.permanent[:remember_token] = person.remember_token
  end

  # Boolean test to prevent a logged in user (person) 
  # from editing anothers user's info.
  # Returns true if the given user is the current user
  def current_person?(person)
    person == current_person
  end


  # Return the current logged-in user (if any).
  # def current_person
  #   @current_person ||= Person.find_by(id: session[:person_id])
  # end

  # Returns the user (person) corresponding to the remember token cookie
  def current_person
    if (person_id = session[:person_id])
      @current_person ||= Person.find_by(id: person_id)
    
    elsif (person_id = cookies.signed[:person_id])
      person = Person.find_by(id: person_id)
      
      if person && person.authenticated?(cookies[:remember_token])
        log_in person
        @current_person = person
      
      end
      
    end
    
  end


  # Return true if the user is logged in, false otherwise.
  def logged_in?
    !current_person.nil?
    
  end

  # Forget user in a persistent session to facilitate successful logout
  def forget(person)
    person.forget
    cookies.delete(:person_id)
    cookies.delete(:remember_token)
  end

  # Log out the current user.
  def log_out
    forget(current_person)
    session.delete(:person_id)
    @current_person = nil
    
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
end
