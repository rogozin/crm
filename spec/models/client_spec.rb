#encoding: utf-8;
require 'spec_helper'

describe Client do
  
  describe 'scopes' do
    it 'owners' do
      client  = Factory(:client)
      owner = Factory(:admin)
      client.client_owners.create(:active => true, :user_id => owner.id)
      client.owners.should eq [owner]
    end
    
    it 'my' do
      client1  = Factory(:client, :state_id => 0)
      client2  = Factory(:client, :state_id => 1)
      client3  = Factory(:client, :state_id => 0).client_owners.create(:user_id => 234)
      owner = Factory(:admin)
      client1.client_owners.create(:active => true, :user_id => owner.id)      
      Client.my(owner.id).should eq [client1, client2]
    end
    
    it 'my!' do
      client1  = Factory(:client, :state_id => 1)
      user = Factory(:user)
      client1.my!(user)
      client1.owners.should eq [user]
      client1.state_id.should be_zero
    end

    it 'reset_my' do
      client1  = Factory(:client, :state_id => 1)
      user = Factory(:user)
      client1.my!(user)
      client1.reset_my!(user)
      client1.owners.should eq [user]
      client1.active_owners.should be_empty
    end
  end
  
end
