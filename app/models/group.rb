class Group < ApplicationRecord
	has_many :users, through: :group_users
	belongs_to :owner, class_name: 'User', foreign_key: 'created_by'
	has_one :modifier, class_name: 'User', foreign_key: 'updated_by'
	validates_presence_of :name

	def create
		super
		GroupUser.create(group_id: id, user_id: created_by, is_admin: true)
	end

	def destroy
		Approval.where(group_id: id).destroy_all
		Post.where(group_id: id).destroy_all
		GroupUser.where(group_id: id).destroy_all
		super
	end

	def update
     	raise 'Group can be made active / inactive by an admin user only' if !is_active_changed? || updated_by.blank? || GroupUser.find(user_id: updated_by, is_admin: true).nil?
    	super
	end
end
