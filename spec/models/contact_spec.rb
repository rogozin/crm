#encoding:utf-8;
require 'spec_helper'

describe Contact do
  
  it 'проверка обязательных полей' do
    c= Contact.new
    c.should have(1).errors_on(:firm_id)
    c.should have(1).errors_on(:current_date)
    c.should have(1).errors_on(:contact_type_id)
    c.should have(1).errors_on(:event_id)
  end
  
  
end
