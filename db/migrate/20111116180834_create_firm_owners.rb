class CreateFirmOwners < ActiveRecord::Migration
  def change
    create_table :client_owners do |t|
      t.integer :client_id
      t.integer :user_id
      t.boolean :active
      t.timestamps
    end
    
  end
end
