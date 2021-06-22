class ApplicationController < ActionController::Base
  protected

  def gateway
    @gateway ||= Gateway.new
  end
end
