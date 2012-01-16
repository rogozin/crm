#encoding: utf-8;
require 'spec_helper'

describe ContactsController do

def valid_attributes 
   Factory.attributes_for(:contact, :client_id => @firm.id)
end

  before(:each) do
    @firm = Factory(:client)
    direct_login_as :first_manager
  end


  describe "GET index" do
    it "все контакты у клиента" do
      contact = Factory(:contact, :client_id => @firm.id)
      contact2 = Factory(:contact, :client_id => @firm.id)
      get :index, :client_id => @firm.id
      assigns(:contacts).should eq([contact, contact2])
    end    
  end
  
  
  describe 'GET my_contacts' do
    it "мои контакты все на сегодня" do
      contact = Factory(:contact, :current_date => Date.yesterday, :next_date => Time.now, :client_id => @firm.id)
      contact2 = Factory(:contact, :current_date => Date.yesterday, :next_date => Time.now, :client_id => @firm.id)
      get :my_contacts
      assigns(:contacts).should eq([contact, contact2])
    end

    it 'фильтр по дате контакта' do
      contact2 = Factory(:contact, :current_date => "01.10.2011", :client_id => 999)      
      contact = Factory(:contact, :current_date => "05.10.2011", :client_id => @firm.id)
      contact3 = Factory(:contact, :current_date => "12.10.2011", :client_id => 998)
      get :my_contacts, :date_from => "05.10.2011", :date_to => "12.10.2011", :next_date_from => "", :next_date_to => ""
      assigns(:contacts).should eq([contact])
    end
    
    it 'фильтр по дате следющего контакта ' do
      contact = Factory(:contact, :next_date => "05.10.2011", :client_id => @firm.id)
      contact2 = Factory(:contact, :next_date => "01.10.2011", :client_id => 999)
      contact3 = Factory(:contact, :next_date => "12.10.2011", :client_id => 998)            
      get :my_contacts, :next_date_from => "05.10.2011",  :next_date_to => "12.10.2011"
      assigns(:contacts).should eq([contact])
    end
    
    it 'Фильтр по менеджеру' do
      contact = Factory(:contact, :next_date => Date.today, :created_by => 1, :client_id => 1)
      contact2 = Factory(:contact, :next_date => Date.today, :created_by => 2, :client_id => 2)
      contact3 = Factory(:contact, :next_date => Date.today, :created_by => 3, :client_id => 3)
      get :my_contacts, :managers => [1,2]
      assigns(:contacts).should eq([contact, contact2])
      
    end


  end

  describe "GET new" do
    it "assigns a new contact as @contact" do
      get :new, :client_id => @firm.id
      assigns(:contact).should be_a_new(Contact)
    end
  end

  describe "GET edit" do
    it "assigns the requested contact as @contact" do
      contact = Contact.create! valid_attributes
      get :edit,  :client_id => @firm.id, :id => contact.id.to_s
      assigns(:contact).should eq(contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Contact" do
        expect {
          post :create, :client_id => @firm.id, :contact => Factory.attributes_for(:contact, :client_id => @firm.id)
        }.to change(Contact, :count).by(1)
      end

      it "assigns a newly created contact as @contact" do
        post :create, :client_id => @firm.id, :contact => Factory.attributes_for(:contact, :client_id => @firm.id)
        assigns(:contact).should be_a(Contact)
        assigns(:contact).should be_persisted
        assigns(:contact).created_by.should eq @user.id
        assigns(:contact).client.should eq @firm
        response.should redirect_to(client_contacts_path(@firm))        
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved contact as @contact" do
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        post :create, :client_id => @firm.id, :contact => {}
        assigns(:contact).should be_a_new(Contact)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        post :create, :client_id => @firm.id, :contact => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
#      it "updates the requested contact" do
#        contact = Contact.create! valid_attributes
#        # Assuming there are no other contacts in the database, this
#        # specifies that the Contact created on the previous line
#        # receives the :update_attributes message with whatever params are
#        # submitted in the request.
#        Contact.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :client_id => @firm.id, :id => contact.id, :contact => {'these' => 'params', 'updated_by' => @user.id}
#      end

      it "assigns the requested contact as @contact" do
        contact = Contact.create! valid_attributes
        put :update, :client_id => @firm.id, :id => contact.id, :contact => valid_attributes
        assigns(:contact).should eq(contact)
      end

      it "redirects to the contact" do
        contact = Contact.create! valid_attributes
        put :update, :client_id => @firm.id, :id => contact.id, :contact => valid_attributes
        response.should redirect_to(client_contacts_path(@firm))
      end
    end

    describe "with invalid params" do
      it "assigns the contact as @contact" do
        contact = Contact.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        put :update, :client_id => @firm.id, :id => contact.id.to_s, :contact => {}
        assigns(:contact).should eq(contact)
      end

      it "re-renders the 'edit' template" do
        contact = Contact.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        put :update, :client_id => @firm.id, :id => contact.id.to_s, :contact => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, :client_id => @firm.id, :id => contact.id.to_s
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to the contacts list" do
      contact = Contact.create! valid_attributes
      delete :destroy, :client_id => @firm.id, :id => contact.id.to_s
      response.should redirect_to(client_contacts_url)
    end
  end

end
