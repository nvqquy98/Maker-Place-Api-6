class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index]
  def index
    render json: parse_json_api(Order.all)
  end
  private
  def parse_json_api order, options = nil
    options ? OrderSerializer.new(order,options).serializable_hash :
    OrderSerializer.new(order).serializable_hash
  end
end
