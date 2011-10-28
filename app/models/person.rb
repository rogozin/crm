class Person < ActiveRecord::Base
  belongs_to :firm
  belongs_to :user
  has_many :contacts
  validates_presence_of :firm_id, :fio
  validates :email, :email2, :email => {:allow_blank => true}
#  validates :email2, :email => {:allow_blank => true}
end
