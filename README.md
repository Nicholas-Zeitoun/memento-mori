Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.


## Notes: Associations and naming

### User Following
To create a new following relation between two users (let's say: user1 is following user2):
```UserFollowing.create!(follower: user1, followed_user: user2)```

To retrieve followers and followed users:
```user.followers # => returns all the followers of that user```
```user.followed_users # => returns all the accounts this user is following```

### Collections
To create a new following relation between a user and a collection (let's say, user1 is following collection1):
```CollectionFollowing.create!(follower: user1, collection: collection1)```

To retrieve collections' data:
```collection.user # => returns the collection's creator```
```collection.followers # => returns the collection's followers```

```user.collections # => returns collections CREATED BY the user```
```user.followed_collections # => returns collections FOLLOWED BY the user```

### Categories
To create a new following relation between a user and a category (let's say, user1 is following category1):
```CategoryFollowing.create!(follower: user1, category: category1)```

To retrieve categories' data:
```category.user # => returns the category's creator```
```category.followers # => returns the category's followers```

```user.categories # => returns categories CREATED BY the user```
```user.followed_categories # => returns categories FOLLOWED BY the user```

## Heroku Deployment
### Manual Resetting of the databse
```Like.delete_all```
```Comment.delete_all```
```UserFollowing.delete_all```
```CategoryFollowing.delete_all```
```CollectionFollowing.delete_all```
```Rarity.delete_all```
```DankRank.delete_all```
```Collect.delete_all```
```Meme.delete_all```
```Collection.delete_all```
```User.delete_all```

```rails db:seed```
