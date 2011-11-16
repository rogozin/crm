#encoding: utf-8;
class PersonsController < ClientsController
  
  before_filter :firm_users, :except => [:index, :destroy]
  
  def index
    params[:page] ||= 1
    params[:per_page] ||= 30
    @persons = Person.where(:firm_id => @firm.id).order("fio").paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  
  def new
    @person = Person.new(:firm => @firm)
  end
  
  
  def edit
    @person = Person.find(params[:id])
  end
  
 def create
    @person = Person.new(params[:person].merge(:created_by => current_user.id))
    if @person.save
      redirect_to client_persons_path(@firm), :notice =>  "Новый #{ Person.model_name.human } успешно создан." 
    else
      render action: "new" 
    end
  end
  
  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person].merge(:updated_by => current_user.id))
      redirect_to client_persons_path(@firm), :notice => "#{ Person.model_name.human } успешно изменен."
    else
      render action: "edit"
    end
  end
  
    def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to client_persons_url, :notice =>  "#{ Person.model_name.human } удален." 
  end

  private 
  
  def firm_users
    @users = User.where(:firm_id => @firm.id).order("username")
  end

end
