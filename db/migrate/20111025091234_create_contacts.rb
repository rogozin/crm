class CreateContacts < ActiveRecord::Migration
  def change
     create_table :contacts do |t|
      t.integer :firm_id, :null => false
      t.datetime :current_date, :null => false
      t.integer :contact_type_id, :null => false
      t.integer :event_id, :null => false
      t.integer :person_id
      t.string :person_name
      t.string :phone
      t.datetime :next_date
      t.text :comment      
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end  
  end
end
