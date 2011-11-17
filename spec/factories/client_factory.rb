#encoding: utf-8;
Factory.sequence :client_seq do |n|
   "ООО Рога и копыта, клон #{n}"
  end

Factory.define :client do |f|
  f.name {Factory.next(:client_seq)}
  f.email "firm@example.com"
  f.url "http://www.example.com"
  f.addr_f "Москва, ул. Льва Толстого д.12 стр. 1"
  f.addr_u "Москва, хата с краю"
  f.city "Москва"
  f.subway "Текстильщики"
  f.show_on_site true
  f.state_id 1
  f.after_create { |firm| firm.update_attribute :short_name, firm.name   }    
end


Factory.define :contact do |f|
  f.current_date { Time.now}
  f.next_date { Time.now + 7.days}
  f.contact_type_id 1
  f.event_id 1
end
