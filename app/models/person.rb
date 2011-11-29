class Person < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  has_many :contacts
  has_many :communications, :as => :ownerable 
  has_many :phones, :as => :ownerable, :class_name => "Communication", :conditions => {:type_id => 0}
  has_many :emails, :as => :ownerable, :class_name => "Communication", :conditions => {:type_id => 1}
  validates_presence_of :client_id, :fio

  accepts_nested_attributes_for :phones, :emails, :reject_if => proc {|attributes| attributes['value'].blank?}, :allow_destroy => true

end
