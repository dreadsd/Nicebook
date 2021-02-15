class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: [:accept, :unfriend]

  def accept
    if current_user.friend_requests.exists?(params[:id])
      @friendship = Friendship.find(params[:id])
      unless @friendship.accept_request
        flash[:error] = "Could not accept friend request"
      end
      redirect_back(fallback_location: root_path)
    else
      not_found
    end
  end

  def unfriend
    if params[:user_id].to_i == current_user.id
      unless current_user.delete_friend(User.find(params[:friend_id]))
        flash[:error] = "Could not unfriend friend"
      end
      redirect_back(fallback_location: root_path)
    else
      not_found
    end
  end


  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end
end
