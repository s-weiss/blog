# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
alice = User.create(name: "alice")
bob = User.create(name: "bob")

2.times do |index|
    Post.create(title: "Alices post #{index + 1}", user: alice)
end

Post.create(title: "Bobs post 1", user: bob)

post = alice.posts.first

comment = Comment.create(content: "A comment", user: alice, post: post)
[alice, bob].each do |user|
  Reaction.create(reaction: 'smile', user: user, comment: comment)
end