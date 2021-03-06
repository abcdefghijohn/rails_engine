module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def show
          merchant_id = params[:id].to_i
          render json: ItemSerializer.new(Item.where("merchant_id=#{merchant_id}"))
        end

        def find
          like_keyword = "%#{merchant_params[:name]}%"
          merchant = Merchant.where('name ILIKE ?', like_keyword).first
          render json: MerchantSerializer.new(merchant)
        end

        def find_all
          like_keyword = "%#{merchant_params[:name]}%"
          merchants = Merchant.where('name ILIKE ?', like_keyword)
          render json: MerchantSerializer.new(merchants)
        end

        private

        def merchant_params
          params.permit(:name, :created_at, :updated_at)
        end
      end
    end
  end
end
