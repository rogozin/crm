#encoding:utf-8;
require 'spec_helper'

describe Communication do
  
  
  context 'check email' do
    it 'email should be email' do
      Communication.new(:value => "sdfds", :type_id => 1).should have(1).error_on(:value)
      Communication.new(:value => "", :type_id => 1).should have(:no).errors_on(:value)
      Communication.new(:value => "admin@mail.ru", :type_id => 1).should have(:no).errors_on(:value)
    end
  end
  

  context 'check url' do
    it 'проверка формата' do
      Communication.new(:value => "http://ya.ru", :type_id => 2).should have(1).error_on(:value)
      Communication.new(:value => "www.ya.ru", :type_id => 2).should have(1).error_on(:value)
      Communication.new(:value => "http://www.ya", :type_id => 2).should have(1).error_on(:value)
      Communication.new(:value => "http://www.mail.ru", :type_id => 2).should have(:no).errors_on(:value)
      Communication.new(:value => "", :type_id => 2).should have(:no).errors_on(:value)
    end
  end

  
  context 'phone' do
    it 'проверка формата' do
       Communication.new(:value => "+8 903 123432", :type_id => 0).should have(1).error_on(:value)        
       Communication.new(:value => "+8 (903) 123432", :type_id => 0).should have(1).error_on(:value)        
       Communication.new(:value => "+8(903)1234-32", :type_id => 0).should have(1).error_on(:value)        
       Communication.new(:value => "+8(903)1234-3232", :type_id => 0).should have(1).error_on(:value)        
       Communication.new(:value => "+8(903)12343232", :type_id => 0).should have(1).error_on(:value)        
       Communication.new(:value => "8(903)123-4323", :type_id => 0).should have(1).error_on(:value)        
       Communication.new(:value => "+8(903)123-4323", :type_id => 0).should have(:no).error_on(:value)        
    end
  end
  
end
