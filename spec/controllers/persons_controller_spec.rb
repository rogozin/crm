require 'spec_helper'

describe PersonsController do
  before do
    @firm = Factory(:client)
    direct_login_as :first_manager
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index, :client_id => @firm
      response.should be_success
    end
  end

end
