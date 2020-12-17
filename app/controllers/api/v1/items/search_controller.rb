module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def show
          item_id = params[:id]
          render json: MerchantSerializer.new(Item.find(item_id).merchant)
        end
        
        def find
          like_keyword = "%#{item_params[:name]}%"
          item = Item.where('name ILIKE ?', like_keyword).first
          render json: ItemSerializer.new(item)
        end

        def find_all
          like_keyword = "%#{item_params[:name]}%"
          items = Item.where('name ILIKE ?', like_keyword)
          render json: ItemSerializer.new(items)
        end

        private
        def item_params
          params.permit(:name, :description, :unit_price, :merchant_id)
        end
      end
    end
  end
end
