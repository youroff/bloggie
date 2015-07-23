module Api
  class BaseController < ActionController::API
    include ActionController::Serialization
    before_action :doorkeeper_authorize!
  end
end