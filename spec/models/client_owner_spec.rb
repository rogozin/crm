#encoding: utf-8;
require 'spec_helper'

describe ClientOwner do
  it 'new record should be active' do
    c = ClientOwner.new
    c.should be_active
    c.should have(1).error_on(:client_id)
    c.should have(1).error_on(:user_id)
  end
  
  it 'у каждого юзера только одна запись может быть активной' do
    oo = ClientOwner.create(:user_id => 1, :client_id => 1, :created_at => Time.now.yesterday)
    o = ClientOwner.create(:user_id => 1, :client_id => 1)    
    
    oo.reload.should_not be_active    
    o.reload.should be_active
  end
  
end
