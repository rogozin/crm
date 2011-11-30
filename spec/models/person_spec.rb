require 'spec_helper'

describe Person do
  it 'firm_id should be not null' do
    Person.new.should have(1).error_on(:client_id)
  end
  
  it 'fio should be not_null' do
   Person.new.should have(1).error_on(:fio)
  end
  

  
end
