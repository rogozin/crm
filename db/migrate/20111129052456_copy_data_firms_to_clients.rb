class CopyDataFirmsToClients < ActiveRecord::Migration
  def up
    Firm.where(:is_supplier => false, :state_id => [0,1,2]).each do |firm|
     c=  Client.create(:id => firm.id, :name => firm.name, :short_name => firm.short_name, :addr_u => firm.addr_u, :addr_f => firm.addr_f,
                     :created_at => firm.created_at, :updated_at => firm.updated_at, :city => firm.city, :subway => firm.subway,
                     :comment => firm.comment, :state_id => firm.state_id, :firm_id => firm.id)
      c.communications.create(:type_id => 0, :value => firm.phone) if firm.phone.present?              
      c.communications.create(:type_id => 0, :value => firm.phone2) if firm.phone2.present?              
      c.communications.create(:type_id => 0, :value => firm.phone3) if firm.phone3.present?              
      c.communications.create(:type_id => 1, :value => firm.email) if firm.email.present?              
      c.communications.create(:type_id => 1, :value => firm.email2) if firm.email2.present?              
      c.communications.create(:type_id => 2, :value => firm.url) if firm.url.present?              
      Person.update_all("client_id = #{c.id}", "client_id =  #{c.firm_id}")
      Contact.update_all("client_id = #{c.id}", "client_id =  #{c.firm_id}")
      ClientOwner.update_all("client_id = #{c.id}", "client_id =  #{c.firm_id}")
     end
     
     Person.all.each do |person|
       person.communications.create(:type_id => 0, :value => person.phone) if person.phone.present?
       person.communications.create(:type_id => 0, :value => person.phone2) if person.phone2.present?
       person.communications.create(:type_id => 0, :value => person.phone3) if person.phone3.present?
       person.communications.create(:type_id => 1, :value => person.email) if person.email.present?
       person.communications.create(:type_id => 1, :value => person.email2) if person.email2.present?
     end
  end

  def down
    execute "truncate table clients"
    execute "truncate table communications"
  end
end
