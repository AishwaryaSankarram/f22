class CreateJoinTableGroupUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :groups, :users do |t|
      t.index [:group_id, :user_id]
      t.boolean :is_admin, default: false
      # t.index [:user_id, :group_id]
    end
  end
end
