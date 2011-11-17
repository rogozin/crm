class ClientOwner < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  validates_presence_of :client_id, :user_id, :active
  
  scope :active, where(:active => true)
  before_create :deactivate
  
  private
  
  def deactivate
    ClientOwner.update_all( {:active => 0}, {:user_id => self.user_id, :client_id => self.client_id} )
  end
end
