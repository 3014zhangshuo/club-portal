class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.references :city
      t.string :name
    end
    add_index :universities, :city_id, :unique => true
  end
end
