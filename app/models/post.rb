class Post < ApplicationRecord
	belongs_to :group
	belongs_to :user, class_name: 'User', foreign_key: 'created_by'
	belongs_to :approver, class_name: 'User', foreign_key: 'approved_by'
	has_many :comments, dependent: :destroy
	validates_presence_of :content
end
