class Post < ActiveRecord::Base
  include Bootsy::Container
  
  belongs_to :user

  validates_presence_of :body

  default_scope { order(created_at: :desc) }

  scope :feed_of, -> (user_id) { joins(user: :followings).where("friendships.user_id" => user_id) }
end
