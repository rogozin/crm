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
      get :new
      assigns(:firm).should be_a_new(Client)
    end
  end

  describe "GET edit" do
    it "assigns the requested firm as @firm" do
      firm = Factory.create(:client)
      get :edit, :id => firm.id.to_s
      assigns(:firm).should eq(firm)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Firm" do
        expect {
          post :create, :firm => {:name => "Рога и копыта" }
        }.to change(Client, :count).by(1)
      end

      it "assigns a newly created firm as @firm" do
        post :create, :firm => {:name => "Рога и копыта" }
        assigns(:firm).should be_a(Client)
        assigns(:firm).should be_persisted
        response.should redirect_to(Client.last)
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
      it "updates the requested firm" do
        firm = Factory(:client)
        # Assuming there are no other firms in the database, this
        # specifies that the Firm created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Firm.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => firm.id, :firm => {'these' => 'params'}
      end

      it "assigns the requested firm as @firm" do
        firm = Factory(:client)
        put :update, :id => firm.id, :firm => {:short_name => "dsfds"}
        assigns(:firm).should eq(firm)
        response.should redirect_to(firm)        
      end
    end

    describe "with invalid params" do
      it "assigns the firm as @firm" do
        firm = Factory(:client)
        # Trigger the behavior that occurs when invalid params are submitted
        Firm.any_instance.stub(:save).and_return(false)
        put :update, :id => firm.id.to_s, :firm => {}
        assigns(:firm).should eq(firm)
        response.should render_template("edit")        
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested firm" do
      firm = Factory(:client)
      expect {
        delete :destroy, :id => firm.id.to_s
      }.to change(Client, :count).by(-1)
    end

    it "redirects to the firms list" do
      firm = Factory(:client)
      delete :destroy, :id => firm.id.to_s
      response.should redirect_to(firms_url)
    end
  end

end
