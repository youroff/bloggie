class Post < ActiveRecord::Base
  include Bootsy::Container
  
  belongs_to :user

  validates_presence_of :body

  default_scope { order(created_at: :desc) }

  scope :feed_of, -> (user_id) { joins(user: :followings).where("friendships.user_id" => user_id) }
  
  def self.kind name
    case name
    when 'my' then Post.where(user_id: current_user.id).order(created_at: :desc)
    when 'feed' then Post.feed_of(current_user.id)
    else
      all
    end
  end
end
