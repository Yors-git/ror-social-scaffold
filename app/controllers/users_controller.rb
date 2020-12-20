class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show create_freindship accept decline]
  before_action :set_post, only: %i[show accept]
  def index
    @users = User.all
  end

  def show
    @friends = @user.friends
    @pending_inv = @user.friend_requests
    @pending_req = @user.pending_friends
  end

  def create_freindship
    Friendship.create(user_id: current_user.id, friend_id: @user.id, confirmed: false)
    # current_user.friendships.create(user_id: current_user.id, friend_id: @user.id, confirmed: false)
    redirect_to request.referrer, notice: 'Friend request sent'
  end

  def accept
    @pending_inv = @user.pending_friends
    data = params[:data]
    user = User.find(data)
    @user.confirm_friend(user)
    redirect_to request.referrer, notice: 'Friend request confirmed'
  end

  def decline
    @pending_inv = @user.pending_friends
    data = params[:data]
    user = User.find(data)
    @user.decline_friend(user)
    redirect_to request.referrer, notice: 'Friend request rejected'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_post
    @posts = @user.posts.ordered_by_most_recent
  end
end
