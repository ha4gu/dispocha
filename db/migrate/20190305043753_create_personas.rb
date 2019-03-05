class CreatePersonas < ActiveRecord::Migration[5.2]
  def change
    create_table :personas do |t|
      t.references :account, foreign_key: true, null: false
      t.references :room, foreign_key: true, null: false
      t.string :name, null: false, default: ""
      t.boolean :accepted, null: false, default: false

      t.timestamps
    end
  end
end
