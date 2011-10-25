class Contact < ActiveRecord::Base
  validates_presence_of :firm_id, :current_date, :event_id, :contact_type_id
end
