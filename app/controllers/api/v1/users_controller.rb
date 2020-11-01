class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    render json: User.all
  end

  def show
    render json: @user if @user
  end

  def create
    user = User.new(user_pramas)
    if user.save
      render json:user, status: :created
    else
      render json:user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_pramas)
      render json: @user, status: :ok
    else
      render json:user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy if @user
    head 204
  end

  private
  def user_pramas
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find_by id: params[:id]
  end
end