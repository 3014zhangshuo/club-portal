class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name, :null => false
      t.string :permalink, :null => false
      t.references :university, :null => false
      t.references :club_type, :null => false
      t.text :intro
      t.string :state, :default => 'blocked', :null => false

      t.timestamps
    end
    add_index :clubs, :university_id
    add_index :clubs, :club_type_id
    add_index :clubs, :permalink, :unique => true
  end
end
