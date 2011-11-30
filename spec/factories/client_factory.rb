#encoding: utf-8;
Factory.sequence :client_seq do |n|
   "ООО Рога и копыта, клон #{n}"
  end

Factory.sequence :phone_seq do |n|
   "+7(495)123-0#{n}"
  end  

Factory.define :client do |f|
  f.name {Factory.next(:client_seq)}
  f.addr_f "Москва, ул. Льва Толстого д.12 стр. 1"
  f.addr_u "Москва, хата с краю"
  f.city "Москва"
  f.subway "Текстильщики"
  f.state_id 1
  f.after_create do |firm| 
    firm.update_attribute :short_name, firm.name
    firm.phones.create(:value => Factory.next(:phone_seq))
  end
end


Factory.define :phone, :class => Communication do |f|
  f.value { Factory.next(:phone_seq)}
  f.type_id 0
end


Factory.define :email, :class => Communication do |f|
  f.value "demo@admin.com"
  f.type_id 1
end

Factory.define :url, :class => Communication do |f|
  f.value "giftb2b.ru"
  f.type_id 2
end

Factory.define :contact do |f|
  f.current_date { Time.now}
  f.next_date { Time.now + 7.days}
  f.contact_type_id 1
  f.event_id 1
end
