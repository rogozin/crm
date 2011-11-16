#encoding: utf-8;
class ContactsController < ClientsController
  before_filter :get_data, :only => [:create, :update, :new, :edit]
  
  # GET /contacts
  # GET /contacts.json
  
  def index
    params[:page] ||=1
    params[:per_page] ||=30
#    params[:sort] = "`current_date`" if params[:sort] == "name"
    @contacts = Contact.where(:firm_id => @firm.id).order("`current_date` desc").paginate(:page => params[:page], :per_page => params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end
  
  def my_contacts
    params[:page] ||=1
    params[:per_page] ||=30
#    params[:sort] = "`current_date`" if params[:sort] == "name"
    @contacts = Contact.order("`current_date` desc").paginate(:page => params[:page], :per_page => params[:per_page])    
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new(:firm => @firm)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact].merge(:created_by => current_user.id))
    
    respond_to do |format|
      if @contact.save
        format.html { redirect_to client_contacts_path(@firm), :notice =>  "Новый #{ Contact.model_name.human } успешно создан."  }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])
    @contact.person_id = nil  if params[:contact][:person_name].present?
    respond_to do |format|
      if @contact.update_attributes(params[:contact].merge(:updated_by => current_user.id))
        format.html { redirect_to client_contacts_path(@firm), :notice =>  "#{ Contact.model_name.human } успешно изменен."}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to client_contacts_path(@firm), :notice =>  "'#{ Contact.model_name.human } удален.'" }
      format.json { head :ok }
    end
  end
  
  private 
  
  def get_data
    @events = Event.order("name")
    @contact_types = ContactType.order("name")
    @persons = Person.where(:firm_id => @firm.id).order("fio")
  end

  
end
