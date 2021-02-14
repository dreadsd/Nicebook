class LikingsController < ApplicationController
  def create
    @liking = Liking.new(liking_params)

    unless @liking.save
      flash[:error] = "Could not like"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    #@liking = Liking.find_by_user_id_and_post_id(params[:liking][:user_id], params[:liking][:post_id])
    @liking = Liking.find(params[:id])
    @liking.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def liking_params
    params.require(:liking).permit(:user_id, :post_id)
  end
end
