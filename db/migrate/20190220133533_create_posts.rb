class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :approved_by
      t.integer :created_by
      t.integer :group_id
      t.text :content

      t.timestamps
    end
  end
end
