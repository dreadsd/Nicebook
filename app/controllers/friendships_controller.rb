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

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_back(fallback_location: root_path)
  end
end
