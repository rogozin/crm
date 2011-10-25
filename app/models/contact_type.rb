#encoding:utf-8;
class ContactType < ActiveRecord::Base
  validates :name, :presence => true
end
