#encoding: utf-8;
require 'spec_helper'

describe Client do
  
  describe 'scopes' do
    before(:each) do
      @client  = Factory(:client, :state_id => 1)
      @owner = Factory(:admin)
    end
    
    it 'owners' do
      @client.client_owners.create(:active => true, :user_id => @owner.id)
      @client.owners.should eq [@owner]
    end
            
    it 'my' do
      client1  = Factory(:client, :state_id => 0)
      client3  = Factory(:client, :state_id => 0).client_owners.create(:user_id => 234)
      client1.client_owners.create(:active => true, :user_id => @owner.id)      
      Client.my(@owner.id).should eq [@client, client1]
    end
    
    it 'my!' do
      @client.my!(@owner)
      @client.owners.should eq [@owner]
      @client.state_id.should be_zero
    end
    
    it 'my?' do
      @client.should_not be_my(@owner)
      @client.my!(@owner)
      @client.should be_my(@owner)      
    end

    it 'reset_my' do
      @client.my!(@owner)
      @client.reset_my!(@owner)
      @client.owners.should eq [@owner]
      @client.active_owners.should be_empty
    end
  end
  
end
