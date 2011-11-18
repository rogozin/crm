#encoding:utf-8;
require 'spec_helper'

describe ClientsController do
  before(:each) do
#    direct_login_as :first_manager
  end

  describe "GET index" do
    before(:each) do
      @firm1 = Factory.create(:client, :state_id => 0)
      @firm1.client_owners.create(:active => true, :user_id => 999)      
      @firm2 = Factory.create(:client, :state_id => 1)      
      @firm3 = Factory.create(:client, :state_id => 2)
    end
    
    it "Главный манагер видит всех клиентов" do      
      direct_login_as :first_manager
      get :index
      assigns(:firms).should eq([@firm1, @firm2, @firm3])
    end
    
    it 'Простой менеджер видит своих клиентов, индюков и дятлов' do
      direct_login_as :second_manager
      @firm4 = Factory.create(:client, :state_id => 0)
      @firm4.client_owners.create(:active => true, :user_id => @user.id)            
      get :index
      assigns(:firms).should eq([@firm2, @firm3, @firm4])      
    end
  end

  describe "GET new" do
    it "assigns a new firm as @firm" do
      direct_login_as :first_manager
      get :new
      assigns(:firm).should be_a_new(Client)
      assigns(:states).should have(3).items
    end
  end

  describe "GET edit" do
    context 'главный менеджер' do
      before(:each) do
        direct_login_as :first_manager        
        @firm = Factory.create(:client)
      end
          
      it "может редактировать любого клиента" do
        get :edit, :id => @firm.id.to_s
        assigns(:firm).should eq(@firm)
      end
    end
    
    context 'второй менеджер' do
      before(:each) do
        direct_login_as :second_manager        
        @firm = Factory.create(:client, :state_id => 0)      
      end
    
      it "может редактировать только своего клиента" do
        @firm.client_owners.create(:user_id => @user.id)
        get :edit, :id => @firm.id.to_s
        assigns(:firm).should eq(@firm)
      end
    
       it "Дятла или индюка нельзя перевести в аисты просто так" do
        @firm.update_attribute(:state_id, 1)
        get :edit, :id => @firm.id.to_s
        assigns(:states).should have(2).items
      end
    
      it "второй менеджер может редактировать индюка или дятла" do
        @firm.update_attribute(:state_id, 1)
        get :edit, :id => @firm.id.to_s
        assigns(:firm).should eq(@firm)
      end    

      it "второй менеджер не может открыть для редактирования чужого клиента" do
        @firm.client_owners.create(:user_id => 999)
        get :edit, :id => @firm.id.to_s
        response.should be_not_found
      end
    end
    
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Firm" do
        direct_login_as :second_manager
        expect {
          post :create, :client => {:name => "Рога и копыта" }
        }.to change(Client, :count).by(1)
      end

      it "assigns a newly created firm as @firm" do
        direct_login_as :second_manager
        post :create, :client => {:name => "Рога и копыта" }
        assigns(:firm).should be_a(Client)
        assigns(:firm).should be_persisted
        assigns(:firm).state_id.should be_zero
        assigns(:firm).users.should eq [@user]
        response.should redirect_to(edit_client_path(Client.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved firm as @firm" do
        # Trigger the behavior that occurs when invalid params are submitted
        Client.any_instance.stub(:save).and_return(false)
        post :create, :firm => {}
        assigns(:firm).should be_a_new(Client)
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested firm as @firm" do
        direct_login_as :first_manager
        @firm = Factory(:client)
        put :update, :id => @firm.id, :client => {:short_name => "Копыта и ко"}
        assigns(:firm).should eq(@firm)
        assigns(:firm).short_name.should eq "Копыта и ко"
        response.should redirect_to(edit_client_path(@firm) )
      end
      
      it 'я выбрасываю аиста в индюки или дятлы' do
        direct_login_as :first_manager
        @firm = Factory(:client, :state_id => 1)
        @firm.my!(@user)
        put :update, :id => @firm.id, :client => {:state_id => 1}
        assigns(:firm).state_id.should eq 1
        assigns(:firm).active_owners.should be_empty 
      end
      
    end

    describe "with invalid params" do
      it "assigns the firm as @firm" do
        firm = Factory(:client)
        # Trigger the behavior that occurs when invalid params are submitted
        Firm.any_instance.stub(:save).and_return(false)
        put :update, :id => firm.id.to_s, :client => {}
        assigns(:firm).should eq(firm)
        response.should render_template("edit")        
      end
    end
  end
  
  describe "DELETE destroy" do    
    before(:each) do
      @firm = Factory(:client)
    end
    
    it "Главный менеджер может удалить фирму" do
      direct_login_as :first_manager
      expect {
        delete :destroy, :id => @firm.id.to_s
      }.to change(Client, :count).by(-1)
      response.should redirect_to(clients_path)
    end    

    it 'Второй менеджер не может удалять фирмы' do
      direct_login_as :second_manager
      expect {
        delete :destroy, :id => @firm.id.to_s
      }.to change(Client, :count).by(0)
      response.should "401"
    end
    
  end  

end
