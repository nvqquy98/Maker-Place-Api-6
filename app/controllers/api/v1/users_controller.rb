class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :check_owner, only: %i[update destroy]
  def index
    render json: parse_json_api(User.all)
  end

  def show
    options = {include: [:products]}
    render json: parse_json_api(@user,options)
  end

  def create
    user = User.new(user_pramas)
    if user.save
      render json:parse_json_api(user), status: :created
    else
      render json:user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_pramas)
      render json: parse_json_api(@user), status: :ok
    else
      render json:user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head 204
  end

  private
  def user_pramas
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find_by id: params[:id]
    head :forbidden unless @user
  end

  def check_owner
    head :forbidden unless @user.id == current_user&.id
  end

  def parse_json_api user, options = nil

    options ? UserSerializer.new(user,options).serializable_hash :
              UserSerializer.new(user).serializable_hash
  end
end
