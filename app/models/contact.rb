class Contact < ActiveRecord::Base
  validates_presence_of :firm_id, :current_date, :event_id, :contact_type_id
  validates :phone, :phone => {:allow_blank => true}
  belongs_to :client, :foreign_key => "firm_id"
  belongs_to :event
  belongs_to :contact_type
  belongs_to :person
  belongs_to :author, :foreign_key => :created_by, :class_name => "User"
end
