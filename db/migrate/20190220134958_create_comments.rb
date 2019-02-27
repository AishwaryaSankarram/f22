class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.text :content
      t.integer :reply_id
      t.integer :created_by

      t.timestamps
    end
  end
end
