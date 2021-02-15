class LikingsController < ApplicationController
  before_action :authenticate_user!, only: :like

  def like
    if Post.exists?(params[:id].to_i)
      @liking = Liking.new(user: current_user, post_id: params[:id])

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
