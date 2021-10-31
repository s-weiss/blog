class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.integer :reaction, null: false
      t.references :comment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
