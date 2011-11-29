#encoding:utf-8;
class Communication < ActiveRecord::Base
  belongs_to :ownerable, :polymorphic => true
  validates :value, :presence => true,  :uniqueness => {:scope => [:ownerable_type, :type_id]}, :phone => {:allow_blank => true}, :if => proc {|c| c.type_id.zero?}
  validates :value, :email => {:allow_blank => true}, :if => proc {|c| c.type_id == 1}
  validates :value, :format => { :with => /\Ahttp:\/\/www\.((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :allow_blank => true }, :if => proc {|c| c.type_id == 2 }
 def self.types
    { "Телефон" => 0, "E-mail" =>  1, "Сайт" => 2 }
  end
end
