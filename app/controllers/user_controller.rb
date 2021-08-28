class UserController < ApplicationController
  before_action :require_session
  
  def require_session
    if !session
      head :forbidden
    end
    if !session.to_hash['user_id']
      head :forbidden
    end
  end

  def info
    @user = User.find(session.to_hash['user_id'])
    render json: @user
  end

end
