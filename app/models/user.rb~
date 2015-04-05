class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :username, :password
  validates_uniqueness_of :username, case_sensitive: false  
end
