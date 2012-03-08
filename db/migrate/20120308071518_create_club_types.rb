class CreateClubTypes < ActiveRecord::Migration
  def change
    create_table :club_types do |t|
      t.string :name
    end
    add_index :club_types, :name, :unique => true
  end
end
