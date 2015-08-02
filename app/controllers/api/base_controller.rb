module Api
  class BaseController < ActionController::API
    include ActionController::Serialization

    private
	  def current_user
	    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
	  end

  end
end