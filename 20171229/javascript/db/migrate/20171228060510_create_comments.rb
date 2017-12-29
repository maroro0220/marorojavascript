class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :contents
      t.integer :user_id
      t.integer :board_id
      t.timestamps null: false
    end
  end
end
