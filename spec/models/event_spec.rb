#encoding: utf-8;
require 'spec_helper'

describe Event do
   
   it 'статус может иметь значение от -1 до 1' do
     Event.new(:name => "asd", :status => -2).should have(1).errors_on(:status)
     Event.new(:name => "asd", :status => -1).should have(:no).errors_on(:status)
     Event.new(:name => "asd", :status => 0).should have(:no).errors_on(:status)
     Event.new(:name => "asd", :status => 1).should have(:no).errors_on(:status)
     Event.new(:name => "asd", :status => 2).should have(1).errors_on(:status)
     Event.new(:name => "asd", :status => "").should have(1).errors_on(:status)
   end
   
   it 'имя не может быть пустым' do
      Event.new(:name => "").should have(1).errors_on(:name)
   end
   
    
end
