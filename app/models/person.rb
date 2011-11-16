class Person < ActiveRecord::Base
  belongs_to :client, :foreign_key => :firm_id
  belongs_to :user
  has_many :contacts
  validates_presence_of :firm_id, :fio
  validates :email, :email2, :email => {:allow_blank => true}
#  validates :email2, :email => {:allow_blank => true}
end
