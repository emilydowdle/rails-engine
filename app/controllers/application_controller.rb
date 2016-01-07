class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def deparameterize(param)
    param == nil ? param : param.gsub("-", " ")
  end
end
