class FriendshipsController < ApplicationController
  before_action :authenticate_user!, only: [:send_request, :accept, :unfriend]
  def send_request
    if User.exists?(params[:id].to_i)
      user = User.find(params[:id].to_i)
      unless current_user.send_request_to(user)
        flash[:error] = "Could not send friend request"
      end
      redirect_back(fallback_location: root_path)
    else
      not_found
    end
  end


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
    if current_user.friends.exists?(params[:id])
      unless current_user.delete_friend(User.find(params[:id]))
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
