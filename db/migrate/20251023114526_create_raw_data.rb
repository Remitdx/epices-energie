class CreateRawData < ActiveRecord::Migration[8.0]
  def change
    create_table :raw_data do |t|
      t.integer :identifier
      t.datetime :datetime
      t.integer :energy
      t.references :daily, null: false, foreign_key: true

      t.timestamps
    end
  end
end
