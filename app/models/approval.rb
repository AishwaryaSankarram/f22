class Approval < ApplicationRecord
	
	belongs_to :group
	belongs_to :from_user, class_name: 'User', foreign_key: 'from_user'
	has_one :to_user, class_name: 'User', foreign_key: 'to_user'
	has_one :created_by, class_name: 'User', foreign_key: 'created_by'
	has_one :updated_by, class_name: 'User', foreign_key: 'updated_by'

	validates_pressence_of :group_id, :created_by


	def create
		if approval_type == 'user' 
			raise "Users can be added by other users only"	if to_user.blank? || from_user.blank? || GroupUser.find(user_id: from_user, group_id: group_id).nil?
		elsif approval_type == 'post'
			raise "Empty post cannot be created / Post should be created by group user only" if content.blank? || created_by.blank? || GroupUser.find(user_id: created_by, group_id: group_id).nil?
		else
			raise "Invalid Approval Type"
		end
		status = "pending_approval" 
		super
	end

	def accept(updated_by)
		if approval_type == 'user' && to_user.present?
			GroupUser.create(group_id: group_id, user_id: to_user)
			update(status: 'approved', updated_by: updated_by)
		elsif approval_type == 'post'
			Post.create(content: content, created_by: from_user, group_id: group_id, approved_by: updated_by)
			update(status: 'approved', updated_by: updated_by)
		end
	end

	def decline(updated_by)
		update(status: 'declined', updated_by: updated_by)
	end

	def update
		if updated_by.present? && GroupUser.find(user_id: updated_by, group_id: group_id, is_admin: true)  && status_changed? && status_was == "pending_approval"
			status == "approved" ? accept(updated_by) : (status == "declined" ? decline(updated_by) : nil )
		end
	end
	
end
