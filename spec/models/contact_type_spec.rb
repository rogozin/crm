#encoding:utf-8;
require 'spec_helper'

describe ContactType do
   it 'имя не может быть пустым' do
      Event.new(:name => "").should have(1).errors_on(:name)
   end
end
