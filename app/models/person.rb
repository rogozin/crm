class Person < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  has_many :contacts
  has_many :communications, :as => :ownerable
  validates_presence_of :client_id, :fio
  
#  validates :email, :email2, :email => {:allow_blank => true}
#  validates :email2, :email => {:allow_blank => true}
end
