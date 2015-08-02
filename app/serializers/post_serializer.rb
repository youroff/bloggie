class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :user_id
  has_one :user, key: :user_id, root: :user
  embed :user, include: true
end
