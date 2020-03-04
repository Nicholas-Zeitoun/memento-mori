class CategoryFollowing < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :category
end
