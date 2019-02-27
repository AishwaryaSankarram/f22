class CreateApprovals < ActiveRecord::Migration[5.2]
  def change
    create_table :approvals do |t|
      t.integer :from_user
      t.integer :group_id
      t.string :status, default: 'pending_approval'
      t.integer :created_by
      t.integer :updated_by
      t.text :content

      t.timestamps
    end
  end
end
