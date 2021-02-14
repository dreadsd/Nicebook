class LikingsController < ApplicationController
  def create
    @liking = Liking.new(liking_params)

    unless @liking.save
      flash[:error] = "Could not like"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @liking = Liking.find(params[:id])
    @liking.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def liking_params
    params.require(:liking).permit(:user_id, :post_id)
  end
end
