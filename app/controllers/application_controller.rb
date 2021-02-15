class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
