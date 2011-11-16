class ClientOwner < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  
  scope :active, where(:active => true)
end
