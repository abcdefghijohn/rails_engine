# frozen_string_literal: true

# merchants controller

module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        render json: MerchantSerializer.new(Merchant.all)
      end

      def show
        id = params[:id]
        render json: MerchantSerializer.new(Merchant.find_by(id: id))
      end

      def create
        merchant = Merchant.create(merchant_params)
        render json: MerchantSerializer.new(merchant)
      end

      def update
        render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
      end

      def destroy
        merchant = Merchant.find(params[:id])
        merchant.delete
      end

      private

      def merchant_params
        params.permit(:name)
      end
    end
  end
end
