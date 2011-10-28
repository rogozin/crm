#encoding: utf-8;
class FirmsController < BaseController
  before_filter :find_firm 
  # GET /firms
  # GET /firms.json
  def index
    params[:page] ||=1
    params[:per_page] ||=30
    @firms = Firm.order("short_name, name").paginate(:page => params[:page], :per_page => params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @firms }
    end
  end

  # GET /firms/new
  # GET /firms/new.json
  def new
    @firm = Firm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @firm }
    end
  end

  # GET /firms/1/edit
  def edit
    @firm = Firm.find(params[:id])
  end

  # POST /firms
  # POST /firms.json
  def create
    @firm = Firm.new(params[:firm])

    respond_to do |format|
      if @firm.save
        format.html { redirect_to edit_firm_path(@firm), :notice =>  "Новый #{ Firm.model_name.human } успешно создан." }
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
    @firm = Firm.find(params[:id])

    respond_to do |format|
      if @firm.update_attributes(params[:firm])
        format.html { redirect_to edit_firm_path(@firm), :notice =>  "#{ Firm.model_name.human } успешно изменен."}
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
    @firm = Firm.find(params[:id])
    @firm.destroy

    respond_to do |format|
      format.html { redirect_to firms_url, :notice =>  "#{ Firm.model_name.human } удален." }
      format.json { head :ok }
    end
  end
  
 protected  
  def find_firm
    @firm = Firm.find(params[:firm_id]) if params[:firm_id]    
  end
  
end
