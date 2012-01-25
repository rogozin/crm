#encoding:utf-8;
class FirmsController < BaseController
  access_control do
    allow "admin", "Главный менеджер","Менеджер продаж"
  end  
  
  def index
    params[:page] ||=1
    params[:per_page] ||=30
    params[:sort]||="created_at" 
    params[:direction]||="desc"
    @firms = Firm.scoped
    
    @firms = @firms.where(:id => params[:id]) if params[:id].present?
    @firms = @firms.where("short_name like :request or name like :request", {:request => "%#{params[:name]}%"}) if params[:name].present?
    @firms = @firms.where("phone like :request", {:request => "%#{params[:phone]}%"}) if params[:phone].present?
    @firms = @firms.where("url like :request", {:request => "%#{params[:site]}%"}) if params[:site].present?
    @firms = @firms.where("email like :request", {:request => "%#{params[:email]}%"}) if params[:email].present?
    @firms = @firms.order(order_string).paginate(:page => params[:page], :per_page => params[:per_page])
  end

  def show
    @firm  = Firm.find(params[:id])
  end

end
