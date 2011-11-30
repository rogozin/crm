#encoding: utf-8;
class PersonsController < ClientsController
  
  before_filter :find_client
  before_filter :firm_users, :except => [:index, :destroy]
  
  def index
    params[:page] ||= 1
    params[:per_page] ||= 30
    @persons = Person.where(:client_id => @firm.id).order("fio").paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  
  def new
    @person = Person.new(:client => @firm)
    build_communications
  end
  
  
  def edit
    @person = Person.find(params[:id])
    build_communications
  end
  
 def create
    @person = Person.new(params[:person].merge(:created_by => current_user.id))
    if @person.save
      redirect_to edit_client_person_path(@firm, @person), :notice =>  "Новый #{ Person.model_name.human } успешно создан." 
    else
      build_communications
      render action: "new" 
    end
  end
  
  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person].merge(:updated_by => current_user.id))
      redirect_to edit_client_person_path(@firm, @person), :notice => "#{ Person.model_name.human } успешно изменен."
    else
      build_communications
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

  def build_communications
    @person.phones.build if @person.phones.empty?   
    @person.emails.build if @person.emails.empty?
  end

end
