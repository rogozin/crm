#encoding: utf-8;
class UsersController < FirmsController
  
  def index
    params[:page] ||= 1
    params[:per_page] ||= 30
    @users = @firm.users.order("username").paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  def stats
    @users  = User.select("distinct users.*").joins(:role_objects).where("roles.group > 1").order("last_request_at desc, created_at desc").paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  


end
