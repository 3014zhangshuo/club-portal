class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :profile, :null => false
      t.references :club, :null => false
      t.string :note
      t.integer :role_level, :null => false, :default => 10
      t.string :state, :null => false, :default => 'blocked'

      t.timestamps
    end
    add_index :memberships, :profile_id
    add_index :memberships, :club_id
  end
end
