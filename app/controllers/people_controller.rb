class PeopleController < ApplicationController
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


  private

    def person_params
      params.require(:person).permit(:name, :email, :password, :password_confirmation)
    end
  
end
