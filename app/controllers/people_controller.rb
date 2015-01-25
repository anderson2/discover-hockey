class PeopleController < ApplicationController

  before_action :logged_in_person, only: [:index, :edit, :update, :destroy]
  before_action :correct_person,   only: [:edit, :update]  
  before_action :admin_person,     only: :destroy


  def index
    @people = Person.paginate(page: params[:page], :per_page => 7)

    
  end

  def show
    @person = Person.find(params[:id])
    @posts = @person.posts.paginate(page: params[:page], :per_page => 5)
    
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

  def destroy
    Person.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to people_url
  end



  private

    def person_params
      params.require(:person).permit(:name, :email, :password, :password_confirmation)
    end
    
    
    # Before filters


    
    # Confirms the correct user.
    def correct_person
      @person = Person.find(params[:id])
      
      #redirect_to(root_url) unless @person == current_person
      redirect_to(root_url) unless current_person?(@person)
      
    end
    
    # Confirms an admin user.
    def admin_person
      redirect_to(root_url) unless current_person.admin?
    end
    
end
