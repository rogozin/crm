#encoding: utf-8;
class PersonsController < ApplicationController
  before_filter :require_user
  before_filter :find_firm
  
  
  def index
    params[:page] ||= 1
    params[:per_page] ||= 30
    @persons = @firm.users.order("username").paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  def stats
    @persons  = User.select("distinct users.*").joins(:role_objects).where("roles.group > 1").order("last_request_at desc, created_at desc").paginate(:page => params[:page], :per_page => params[:per_page])
  end
  
  
  private
  
  def find_firm
    @firm = Firm.find(params[:firm_id]) if params[:firm_id]
    
  end

end
