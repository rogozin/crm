require 'spec_helper'

describe ContactsController do

  before(:each) do
    @firm = Factory(:client)
    direct_login_as :first_manager
  end


  describe "GET index" do
    it "assigns all contacts as @contacts" do
      contact = Factory(:contact, :firm => @firm)
      get :index, :client_id => @firm.id
      assigns(:contacts).should eq([contact])
    end
  end

  describe "GET new" do
    it "assigns a new contact as @contact" do
      get :new
      assigns(:contact).should be_a_new(Contact)
    end
  end

  describe "GET edit" do
    it "assigns the requested contact as @contact" do
      contact = Contact.create! valid_attributes
      get :edit, :id => contact.id.to_s
      assigns(:contact).should eq(contact)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Contact" do
        expect {
          post :create, :client_id => @firm.id, :contact => Factory.attributes_for(:contact, :firm_id => @firm.id)
        }.to change(Contact, :count).by(1)
      end

      it "assigns a newly created contact as @contact" do
        post :create, :client_id => @firm.id, :contact => Factory.attributes_for(:contact, :firm_id => @firm.id)
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
      it "updates the requested contact" do
        contact = Contact.create! valid_attributes
        # Assuming there are no other contacts in the database, this
        # specifies that the Contact created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Contact.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => contact.id, :contact => {'these' => 'params'}
      end

      it "assigns the requested contact as @contact" do
        contact = Contact.create! valid_attributes
        put :update, :id => contact.id, :contact => valid_attributes
        assigns(:contact).should eq(contact)
      end

      it "redirects to the contact" do
        contact = Contact.create! valid_attributes
        put :update, :id => contact.id, :contact => valid_attributes
        response.should redirect_to(contact)
      end
    end

    describe "with invalid params" do
      it "assigns the contact as @contact" do
        contact = Contact.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        put :update, :id => contact.id.to_s, :contact => {}
        assigns(:contact).should eq(contact)
      end

      it "re-renders the 'edit' template" do
        contact = Contact.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Contact.any_instance.stub(:save).and_return(false)
        put :update, :id => contact.id.to_s, :contact => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested contact" do
      contact = Contact.create! valid_attributes
      expect {
        delete :destroy, :id => contact.id.to_s
      }.to change(Contact, :count).by(-1)
    end

    it "redirects to the contacts list" do
      contact = Contact.create! valid_attributes
      delete :destroy, :id => contact.id.to_s
      response.should redirect_to(contacts_url)
    end
  end

end
