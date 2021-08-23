class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :movie
      t.references :user, foreign_key: true
      t.integer :duration
      t.date :date
      t.time :start_time

      t.timestamps
    end
  end
end
