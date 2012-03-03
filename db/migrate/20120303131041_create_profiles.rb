class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :name
      t.date :birth
      t.string :mobile
      t.string :email
      t.string :qq
      t.integer :gender
      t.string :hometown
      t.text :bio

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
