class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: :accept

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
      fst_frnd = Friendship.find_by(user_id: params[:user_id], friend_id: params[:friend_id])
      scd_frnd = Friendship.find_by(user_id: params[:friend_id], friend_id: params[:user_id])
      if !(fst_frnd.destroy && scd_frnd.destroy)
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
