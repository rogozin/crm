#encoding: utf-8;
class ClientsController < BaseController
  before_filter :find_firm, :only => [:new, :edit, :update, :create, :destroy]
  before_filter :select_form_data, :only => [:new, :edit, :update, :create]
  access_control do
    allow "Администратор", "Главный менеджер"
    allow "Менеджер продаж", :except => [:destroy]
  end
  
   
  # GET /firms
  # GET /firms.json
  def index
    params[:page] ||=1
    params[:per_page] ||=30
    params[:sort]||="name" 
    params[:direction]||="asc"
    @firms = Client.scoped
    @firms = @firms.where("short_name like :request or name like :request", {:request => "%#{params[:name]}%"}) if params[:name].present?
    @firms = @firms.order(order_string).paginate(:page => params[:page], :per_page => params[:per_page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @firms }
    end
  end

  # GET /firms/new
  # GET /firms/new.json
  def new
    @firm = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @firm }
    end
  end

  # GET /firms/1/edit
  def edit
#    @firm = Client.find(params[:id])
  end

  # POST /firms
  # POST /firms.json
  def create
    @firm = Client.new(params[:client].merge(:state_id => 0))

    respond_to do |format|
      if @firm.save
        @firm.client_owners.create(:user => current_user)
        format.html { redirect_to edit_client_path(@firm), :notice =>  "Новый #{ Client.model_name.human } успешно создан." }
        format.json { render json: @firm, status: :created, location: @firm }
      else
        format.html { render action: "new" }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /firms/1
  # PUT /firms/1.json
  def update
    respond_to do |format|            
      if @firm.update_attributes(params[:client])
        format.html { redirect_to edit_client_path(@firm), :notice =>  "#{ Client.model_name.human } успешно изменен."}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @firm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /firms/1
  # DELETE /firms/1.json
  def destroy
    @firm = Client.find(params[:id])
    return redirect_to clients_path, :alert => "Не могу удалить. На этом клиенте висят персоны" if @firm.persons.present?
    return redirect_to clients_path, :alert => "Не могу удалить. На этом клиенте висят контакты" if @firm.contacts.present?
    return redirect_to clients_path, :alert => "Не могу удалить. На этом клиенте висят пользователи" if @firm.users.present?
    @firm.destroy

    respond_to do |format|
      format.html { redirect_to clients_url, :notice =>  "#{ Client.model_name.human } удален." }
      format.json { head :ok }
    end
  end
  
 protected  
  def find_firm
    if controller_name == "clients"
      @firms_scope = current_user.is_first_manager? ? Client.scoped : Client.my(current_user.id)
      @firm = @firms_scope.find(params[:id]) if params[:id]  
    end
  end
  
  def find_client
   @firms_scope = current_user.is_first_manager? ? Client.scoped : Client.my(current_user.id)
   @firm = @firms_scope.find(params[:client_id])  if params[:client_id]
  end
  
  def select_form_data
    @states= Client.states.to_a[0..3]
    @states.delete_at(0) if @firm && @firm.free?
  end
  
end
