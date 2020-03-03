class CollectionFollowing < ApplicationRecord
  belongs_to :followed_collection, foreign_key: :followed_collection_id, class_name: 'Collection'
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'
end
