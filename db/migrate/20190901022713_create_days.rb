class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.integer :weekday
      t.string :start
      t.string :finish
      t.belongs_to :schedule, foreign_key: true

      t.timestamps
    end
  end
end
