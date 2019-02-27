class AddColumnToUserToApprovals < ActiveRecord::Migration[5.2]
  def change
    add_column :approvals, :to_user, :integer
    add_column :approvals, :approval_type, :string
  end
end
