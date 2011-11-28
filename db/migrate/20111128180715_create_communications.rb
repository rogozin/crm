class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.references :ownerable, :polymorphic => true
      t.string :value
      t.integer :type_id
      t.timestamps
    end
  end
end
