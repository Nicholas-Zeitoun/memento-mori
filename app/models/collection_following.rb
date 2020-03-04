class CollectionFollowing < ApplicationRecord
  belongs_to :collection
  belongs_to :follower, class_name: 'User'
end
