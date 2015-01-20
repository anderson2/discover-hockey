class PeopleController < ApplicationController

  before_action :logged_in_person, only: [:index, :edit, :update]
  before_action :correct_person,   only: [:edit, :update]  


  def index
    @people = Person.paginate(page: params[:page], :per_page => 10)

    
  end

  def show
    @person = Person.find(params[:id])
    
    #debugger
    
  end

  def new
    @person = Person.new
    
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      # Handle a successful save
      log_in @person
      
      flash[:success] = "Welcome to Discover Hockey!!"
      redirect_to @person
      
    else
      render 'new'
    end
  end

  def edit
    @person = Person.find(params[:id])
    
  end
  
  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(person_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @person
      
    else
      render 'edit'
    end 
  end



  private

    def person_params
      params.require(:person).permit(:name, :email, :password, :password_confirmation)
    end
    
    
    # Before filters

    # Confirms a logged-in user.
    def logged_in_person
      unless logged_in?
        store_location
        flash[:danger] = "Please sign in to continue"
        redirect_to login_url
        
      end
    end
    
    # Confirms the correct user.
    def correct_person
      @person = Person.find(params[:id])
      
      #redirect_to(root_url) unless @person == current_person
      redirect_to(root_url) unless current_person?(@person)
      
    end
    
end
