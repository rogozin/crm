class Event < ActiveRecord::Base
  validates :status, :inclusion => {:in => -1..1}
  validates :name, :presence => true
end
