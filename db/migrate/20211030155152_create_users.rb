class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, uniq: true, null: false

      t.timestamps
    end
  end
end
