class FriendshipsController < ApplicationController
  def accept
    if current_user.friend_requests.exists?(params[:id])
      @friendship = Friendship.find(params[:id])
      unless @friendship.accept_request
        flash[:error] = "Could not accept friend request"
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end
end
