  Firm.instance_eval do
    has_many :contacts, :dependent => :restrict
    has_many :persons, :dependent => :restrict
  end
