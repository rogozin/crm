module ContactsHelper
  def event_status_class_name(event_status)
    event_status == 0 ? nil : (event_status == -1 ? "event_poor" : "event_good")
  end
  
  def person_name contact
    contact.person ? contact.person.fio : contact.person_name
  end
  
end
