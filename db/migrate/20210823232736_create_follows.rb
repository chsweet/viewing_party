class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :hosts_id, foreign_key: true
      t.integer :followeds_id, foreign_key: true

      t.timestamps
    end
  end
end
