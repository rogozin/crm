class RemoveExcessedColumns < ActiveRecord::Migration
  def up
    remove_column :firms, :comment, :phone2, :phone3, :email2, :state_id
    remove_column :persons, :phone, :phone2, :phone3, :email, :email2
  end

  def down
    add_column :firms, :state_id, :integer, :default => 1
    add_column :firms, :comment, :text
    add_column :firms, :phone2, :string
    add_column :firms, :phone3, :string
    add_column :firms, :email2, :string    
    add_column :persons, :phone, :string
    add_column :persons, :phone2, :string
    add_column :persons, :phone3, :string
    add_column :persons, :email, :string    
    add_column :persons, :email2, :string    
  end
end
