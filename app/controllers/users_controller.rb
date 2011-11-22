#encoding: utf-8;
class UsersController < ClientsController   
  before_filter :find_client, :only => [:index] 
  before_filter :load_roles, :only => [:edit, :update]

  def index
    params[:page] ||= 1
    params[:per_page] ||= 30
    @users = @firm.users.order("username").paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  def stats
    @users  = User.select("distinct users.*").joins(:role_objects).where("roles.group > 1").order("last_request_at desc, created_at desc").paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  
  def edit
    @user = User.find(params[:id])
    @firm = @user.firm
  end
  
  def update
    @user = User.find(params[:id])    
    @user.errors[:firm_id] = "такого ID не существует" if params[:user][:firm_id] != @user.firm_id.to_s && !Client.exists?(params[:user][:firm_id])
    if @user.errors.empty? && @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user), :notice => "Учетная запись пользователя изменена"
    else 
      @firm = @user.firm
      render :edit
    end
  end
  
  private
  
  def load_roles
    @roles = Role.where(:group => 2)
    @hidden_roles = Role.where "`group` <> 2"
  end
  


end
