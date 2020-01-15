class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  def create
    @micropost = current_user.microposts.build micropost_params
    if @micropost.save
      flash[:success] = t ".micropost_success"
      redirect_to root_url
    else
      @feed_items = []
      flash[:danger] = t ".micropost_failed"
    end
  end

  def destroy
    @mircopost.destroy
    flash[:success] = t ".micropost_deleted"
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @mircopost = current_user.microposts.find_by id: params[:id]
    redirect_to_root_url if @mircopost.nil?
  end
end
