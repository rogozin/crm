class CreatePersons < ActiveRecord::Migration
  def change
    create_table :persons do |t|
      t.integer :firm_id, :null => false
      t.integer :user_id
      t.string :fio
      t.string :appoint
      t.string :phone, :phone2, :phone3
      t.string :email, :email2
      t.text :comment
      t.integer :created_by, :updated_by
      t.timestamps
    end
  end
end
