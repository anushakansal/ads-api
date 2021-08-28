class AdvertisementsController < ApplicationController
  before_action :require_session
  
  def require_session
    if !session
      head :forbidden
    end
    if !session.to_hash['user_id']
      head :forbidden
    end
  end

  def index
    @ads = Advertisement.joins(:user)
      .select('advertisements.id, advertisements.title, advertisements.description, advertisements.action_text, advertisements.action_url, advertisements.action_color, advertisements.created_at, advertisements.user_id, users.name as user_name')
      .order(created_at: :desc) 
    render json: @ads
  end

  def show
    @ad = Advertisement.joins(:user)
      .select('advertisements.id, advertisements.title, advertisements.description, advertisements.action_text, advertisements.action_url, advertisements.action_color, advertisements.created_at, advertisements.user_id, users.name as user_name')
      .find(params[:id])
    render json: @ad
  end

  def create
    @ad = Advertisement.create(
      user_id: session.to_hash['user_id'],
      title: params[:title],
      description: params[:description],
      action_text: params[:action_text],
      action_url: params[:action_url],
      action_color: params[:action_color],
      published: params[:published]
    )
    render json: @ad
  end

  def update
    @ad = Advertisement.find(params[:id])
    if(@ad.user_id != session.to_hash['user_id'])
      head :bad_request
    end
    @ad.update(
      title: params[:title],
      description: params[:description],
      action_text: params[:action_text],
      action_url: params[:action_url],
      action_color: params[:action_color],
      published: params[:published]
    )
    render json: @ad
  end

  def destroy
    @ad = Advertisement.find(params[:id])
    if(@ad.user_id != session.to_hash['user_id'])
      head :bad_request
    end
    Comment.where(advertisement_id: params[:id]).destroy_all
    @ad.destroy
    render json: @ad
  end

  def comments_on_ad
    @comments = Comment.joins(:user).select('comments.id, comments.text, comments.user_id, users.name as user_name').where(advertisement_id: params[:id])
    render json: @comments
  end
end
