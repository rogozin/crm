require 'spec_helper'

describe Person do
  it 'firm_id should be not null' do
    Person.new.should have(1).error_on(:firm_id)
  end
  
  it 'fio should be not_null' do
   Person.new.should have(1).error_on(:fio)
  end
  
  
  it 'email should be email' do
   Person.new(:email => "sdfds").should have(1).error_on(:email)
   Person.new(:email => "").should have(:no).errors_on(:email)
   Person.new(:email2 => "sdfds").should have(1).error_on(:email2)
   Person.new(:email2 => "").should have(:no).errors_on(:email2)
  end
  
end
