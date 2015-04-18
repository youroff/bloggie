class Post < ActiveRecord::Base
  include Bootsy::Container
  
  belongs_to :user

  validates_presence_of :body
end
