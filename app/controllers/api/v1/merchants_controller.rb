class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    id = params[:id]
    render json: MerchantSerializer.new(Merchant.find_by(id: id))
  end

  def create
    render json:MerchantSerializer.new(Merchant.create{:name})
  end
end
