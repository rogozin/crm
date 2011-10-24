require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe FirmsController do

  # This should return the minimal set of attributes required to create a valid
  # Firm. As you add validations to Firm, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all firms as @firms" do
      firm = Firm.create! valid_attributes
      get :index
      assigns(:firms).should eq([firm])
    end
  end

  describe "GET show" do
    it "assigns the requested firm as @firm" do
      firm = Firm.create! valid_attributes
      get :show, :id => firm.id
      assigns(:firm).should eq(firm)
    end
  end

  describe "GET new" do
    it "assigns a new firm as @firm" do
      get :new
      assigns(:firm).should be_a_new(Firm)
    end
  end

  describe "GET edit" do
    it "assigns the requested firm as @firm" do
      firm = Firm.create! valid_attributes
      get :edit, :id => firm.id
      assigns(:firm).should eq(firm)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Firm" do
        expect {
          post :create, :firm => valid_attributes
        }.to change(Firm, :count).by(1)
      end

      it "assigns a newly created firm as @firm" do
        post :create, :firm => valid_attributes
        assigns(:firm).should be_a(Firm)
        assigns(:firm).should be_persisted
      end

      it "redirects to the created firm" do
        post :create, :firm => valid_attributes
        response.should redirect_to(Firm.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved firm as @firm" do
        # Trigger the behavior that occurs when invalid params are submitted
        Firm.any_instance.stub(:save).and_return(false)
        post :create, :firm => {}
        assigns(:firm).should be_a_new(Firm)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Firm.any_instance.stub(:save).and_return(false)
        post :create, :firm => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested firm" do
        firm = Firm.create! valid_attributes
        # Assuming there are no other firms in the database, this
        # specifies that the Firm created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Firm.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => firm.id, :firm => {'these' => 'params'}
      end

      it "assigns the requested firm as @firm" do
        firm = Firm.create! valid_attributes
        put :update, :id => firm.id, :firm => valid_attributes
        assigns(:firm).should eq(firm)
      end

      it "redirects to the firm" do
        firm = Firm.create! valid_attributes
        put :update, :id => firm.id, :firm => valid_attributes
        response.should redirect_to(firm)
      end
    end

    describe "with invalid params" do
      it "assigns the firm as @firm" do
        firm = Firm.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Firm.any_instance.stub(:save).and_return(false)
        put :update, :id => firm.id, :firm => {}
        assigns(:firm).should eq(firm)
      end

      it "re-renders the 'edit' template" do
        firm = Firm.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Firm.any_instance.stub(:save).and_return(false)
        put :update, :id => firm.id, :firm => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested firm" do
      firm = Firm.create! valid_attributes
      expect {
        delete :destroy, :id => firm.id
      }.to change(Firm, :count).by(-1)
    end

    it "redirects to the firms list" do
      firm = Firm.create! valid_attributes
      delete :destroy, :id => firm.id
      response.should redirect_to(firms_url)
    end
  end

end
