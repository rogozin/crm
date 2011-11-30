class FirmsController < ApplicationController
  def index
    params[:page] ||=1
    params[:per_page] ||=30
    @firms = Firm.where("not exists (select null from clients c where c.firm_id = firms.id)").order("created_at desc").paginate(:page => params[:page], :per_page => params[:per_page])
  end

  def show
    @firm  = Firm.find(params[:id])
  end

end
