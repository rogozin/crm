class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.references :ownerable, :polymorphic => true
      t.string :value
      t.integer :type_id, :default => 0
      t.timestamps
    end
  end
end
