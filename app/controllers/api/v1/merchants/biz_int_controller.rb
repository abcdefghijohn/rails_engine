module Api
  module V1
    module Merchants
      class BizIntController < ApplicationController
        def most_revenue
          quantity = params[:quantity].to_i
          info = Merchant.most_revenue(quantity)
          render json: MerchantSerializer.new(info).serializable_hash.to_json
        end

        def most_items
          quantity = params[:quantity].to_i
          info = Merchant.most_items(quantity)
          render json: MerchantSerializer.new(info)
        end
      end
    end
  end
end
