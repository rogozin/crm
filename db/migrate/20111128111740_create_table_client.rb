class CreateTableClient < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.string :name
      t.string :short_name
      t.text :addr_u, :addr_f, :comment
      t.string :city, :subway
#      t.string :phone, :phone2, :phone3
#      t.string :email, :email2
#      t.string :url, :url2
      t.integer :state_id, :default => 1
      t.timestamps
      t.integer :created_by, :updated_by
    end 
        
  end

  def down
    drop_table :clients
  end
end
