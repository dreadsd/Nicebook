class LikingsController < ApplicationController
  before_action :authenticate_user!, only: :like

  def like
    if params[:user_id].to_i == current_user.id
      @liking = Liking.new(user_id: params[:user_id].to_i, post_id: params[:post_id].to_i)

      unless @liking.save
        flash[:error] = "Could not like"
      end
      redirect_back(fallback_location: root_path)
    else
      not_found
    end
  end

  def destroy
    @liking = Liking.find(params[:id])
    @liking.destroy
    redirect_back(fallback_location: root_path)
  end
end
