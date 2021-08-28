class CommentsController < ApplicationController
  before_action :require_session
  
  def require_session
    if !session
      head :forbidden
    end
    if !session.to_hash['user_id']
      head :forbidden
    end
  end

  def create
    @comment = Comment.create(
      user_id: session.to_hash['user_id'],
      advertisement_id: params[:advertisement_id],
      text: params[:text]
    )
    render json: @comment
  end

  def update
    @comment = Comment.find(params[:id])
    if(@comment.user_id != session.to_hash['user_id'])
      head :bad_request
    end
    @comment.update(
      text: params[:text]
    )
    render json: @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    if(@comment.user_id != session.to_hash['user_id'])
      head :bad_request
    end
    @comment.destroy
    render json: @comment
  end
end
