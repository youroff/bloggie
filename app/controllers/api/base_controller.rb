module Api
  class BaseController < ActionController::API
    include ActionController::Serialization
  end
end