#encoding: utf-8;
class UsersController < FirmsController   
  before_filter :load_roles, :only => [:edit, :update]

  def index
    params[:page] ||= 1
    params[:per_page] ||= 30
    @firm = Firm.find(params[:firm_id])
    @users = @firm.users.order("username").paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  def stats
    params[:sort]||="current_sign_in_at" 
    params[:direction]||="desc"
    @users  = User.select("distinct users.*").joins(:role_objects).where("roles.group > 1").order(order_string).paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  
  def edit
    @user = User.find(params[:id])
    @firm = @user.firm 
    return redirect_to :stats, :alert => "Недостаточно прав для просмотра страницы" if current_user.is_second_manager? && !(@firm.client.free? || @firm.client.my?(current_user))
  end
  
  def update
    @user = User.find(params[:id])    
    @user.errors[:firm_id] = "такого ID не существует" if params[:user][:firm_id] != @user.firm_id.to_s && !Firm.exists?(params[:user][:firm_id])
    if @user.errors.empty? && @user.update_attributes(params[:user], :as => :crm)
      redirect_to edit_user_path(@user), :notice => "Учетная запись пользователя изменена"
    else 
      @firm = @user.firm
      render :edit
    end
  end
  
  private
  
  def load_roles
    @roles = Role.where(:group => [2,5])
    @hidden_roles = Role.where "`group` <> 2"
  end
  


end
