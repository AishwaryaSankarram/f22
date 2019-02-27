class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.boolean :is_active
      t.integer :updated_by
      t.integer :created_by

      t.timestamps
    end
  end
end
