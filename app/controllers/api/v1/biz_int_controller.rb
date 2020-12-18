module Api
  module V1
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

      def revenue_dates
        start_date = params[:start]
        end_date = params[:end]
        revenue_info = Invoice.revenue_dates(start_date, end_date)
        render json: RevenueSerializer.revenue(revenue_info)
      end
    end
  end
end
