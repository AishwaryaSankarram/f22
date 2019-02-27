class User < ApplicationRecord
	has_and_belongs_to_many :groups
	validates_presence_of :name
	
	#Group Owners should not be deleted
	#An approval pending user when deleted, should be deleted from approval table as the user no longer exists 
	def destroy
		raise "Cannot delete group owners" if Group.where(created_by: id).count > 0
		user_approvals = Approval.where(to_user: id, status: 'pending_approval')
		user_approvals.destroy_all if user_approvals.length > 0
		super
	end

	#Group Owners cannot leave group
	def leave_group(group_id)
		GroupUser.destroy(user_id: user_id, group_id: group_id) unless Group.find(group_id).created_by == id
	end

	
end
