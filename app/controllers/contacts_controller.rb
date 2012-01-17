#encoding: utf-8;
class ContactsController < ClientsController
  before_filter :find_client
  before_filter :get_data, :only => [:create, :update, :new, :edit]
  before_filter :default_sort, :only => [:index, :my_contacts]
  access_control do
    allow "Администратор", "Главный менеджер"
    allow "Менеджер продаж", :except => [:destroy, :edit, :update]
  end  
  # GET /contacts
  # GET /contacts.json
  
  def index
    @contacts = Contact.where(:client_id => @firm.id).order(order_string).paginate(:page => params[:page], :per_page => params[:per_page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end
  
  def my_contacts
    params[:next_date_from] ||= Date.today
    params[:next_date_to] ||= Date.tomorrow 
    @managers = User.where(:id => Contact.select("distinct created_by").map(&:created_by))
    @contacts = Contact.scoped
    @contacts = @contacts.joins(", (select  client_id, max(id) id from contacts group by client_id order by client_id) cc").where("cc.id = contacts.id") unless params[:show_all].present?
    @contacts = @contacts.where("`current_date` >= :date_from", {:date_from => params[:date_from].to_time(:local)}) if params[:date_from].present?
    @contacts = @contacts.where("`current_date` < :date_to", {:date_to => params[:date_to].to_time(:local)}) if params[:date_to].present?
    @contacts = @contacts.where("`next_date` >= :date_from", {:date_from => params[:next_date_from].to_time(:local)}) if params[:next_date_from].present?
    @contacts = @contacts.where("`next_date` < :date_to", {:date_to => params[:next_date_to].to_time(:local)}) if params[:next_date_to].present?    
    @contacts = @contacts.where(:created_by => params[:managers]) if current_user.is_first_manager? && params[:managers].present?
    @contacts = @contacts.where(:created_by => current_user.id) unless current_user.is_first_manager?
    @contacts = @contacts.order(order_string).paginate(:page => params[:page], :per_page => params[:per_page])    
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new(:client => @firm, :current_date => Time.now, :next_date => 7.days.from_now.to_date)

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
        @contact.client.my!(current_user) if @firm.free?  || current_user.is_first_manager?
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
    @persons = Person.where(:client_id => @firm.id).order("fio")
  end

  def default_sort
    params[:sort]||="`current_date`" 
    params[:direction]||="desc" 
    params[:page] ||=1
    params[:per_page] ||=30    
  end
  
end
