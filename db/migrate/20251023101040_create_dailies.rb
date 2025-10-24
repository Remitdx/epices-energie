class CreateDailies < ActiveRecord::Migration[8.0]
  def change
    create_table :dailies do |t|
      t.datetime :date
      t.integer :energy

      t.timestamps
    end
  end
end
