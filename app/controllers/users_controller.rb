class UsersController < ApplicationController
  PER_PAGE = 5

  def index
    @users = User.order(:id).page(params[:page]).per(PER_PAGE)
  end

  def show
    @user = User.find(params[:id])
  end
end
