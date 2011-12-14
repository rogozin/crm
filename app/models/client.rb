#encoding: utf-8;
class Client < ActiveRecord::Base
  acts_as_authorization_object
  validates :name, :presence => true, :uniqueness => true
  validates :firm_id,  :uniqueness => { :allow_blank => true}
  has_many :contacts, :dependent => :restrict
  has_many :persons, :dependent => :restrict
  has_many :users, :foreign_key => :firm_id
  has_many :client_owners, :dependent => :delete_all
  has_many :owners, :through => :client_owners, :source => :user
  has_many :communications, :as => :ownerable, :dependent => :delete_all
  has_many :phones, :as => :ownerable, :class_name => "Communication", :conditions => {:type_id => 0}
  has_many :emails, :as => :ownerable, :class_name => "Communication", :conditions => {:type_id => 1}
  has_many :sites, :as => :ownerable, :class_name => "Communication", :conditions => {:type_id => 2}
  belongs_to :firm
  validates :state_id, :presence => true
  scope :free, where(:state_id => [1,2,3])
  scope :my, lambda {|user_id| where("(state_id in (1,2,3)) or (state_id = 0 and exists (select null from client_owners co where co.client_id = clients.id and co.user_id  = #{user_id} and active = 1))")}
  after_save :reset_all

   accepts_nested_attributes_for :phones,  :allow_destroy => true
   accepts_nested_attributes_for :emails, :sites, :reject_if => proc {|attributes| attributes['value'].blank?}, :allow_destroy => true

  def active_owners
    client_owners.where(:active => true).order("created_at desc")
  end  
  
  def self.states
    {"Аист" => 0, "Индюк" => 1, "Дятел" => 2, "Новый" => 3}
  end
  
  def state
    self.class.states.flatten[state_id*2]
  end  
  
  def free?
    [1,2,3].include?(self.state_id)
  end  
  
  def my?(user)
    active_owners.exists?(:user_id => user.id)    
  end
  
  def my!(user)
    client_owners.create(:user_id => user.id)
    update_attribute :state_id, 0
  end
  
  def reset_my!(user)
    self.client_owners.where({:user_id => user.id, :active => true}).update_all("active = 0")
  end


  private  
  def reset_all
    self.active_owners.update_all("active=0") if state_id_changed? && state_id_was == 0
  end
end
