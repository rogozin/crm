#encoding: utf-8;
class Client < Firm
  acts_as_authorization_object
  has_many :contacts, :foreign_key => :firm_id, :dependent => :restrict
  has_many :persons, :foreign_key => :firm_id, :dependent => :restrict
  has_many :users, :foreign_key => :firm_id
  has_many :client_owners
  has_many :owners, :through => :client_owners
  
  
  def self.states
    {"Аист" => 0, "Индюк" => 1, "Дятел" => 2}
  end
  
  def state
    self.class.states.flatten[state_id*2]
  end  
  
end
