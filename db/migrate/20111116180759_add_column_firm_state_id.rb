class AddColumnFirmStateId < ActiveRecord::Migration
  def up
    add_column :firms, :state_id, :integer, :default => 1
  end

  def down
    remove_column :firms, :state_id
  end
end
