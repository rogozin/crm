class Client < Firm
  acts_as_authorization_object
  has_many :contacts, :foreign_key => :firm_id, :dependent => :restrict
  has_many :persons, :foreign_key => :firm_id, :dependent => :restrict
end
