#  Firm.instance_eval do
#    has_many :contacts, :dependent => :restrict
#    has_many :persons, :dependent => :restrict
#  end

#module FirmExtension
#  def self.included(base)
#    base.extend(ClassMethods)
#  end
#  module ClassMethods
#    has_many :contacts, :dependent => :restrict
#    has_many :persons, :dependent => :restrict
#  end
#end

#Firm.send(:include, FirmExtension)
