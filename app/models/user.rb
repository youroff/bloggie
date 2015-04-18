class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :first_name, :last_name, :username
  validates_uniqueness_of :username, case_sensitive: false
  
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :followings, class_name: Friendship, foreign_key: :friend_id
  has_many :followers, through: :followings, source: :user

  has_many :posts
end
