module Api
  module V1
    class ItemsController < ApplicationController
      def index
        render json: ItemSerializer.new(Item.all)
      end

      def show
        id = params[:id]
        render json: ItemSerializer.new(Item.find_by(id: id))
      end

      def create
        item = Item.create(item_params)
        render json: ItemSerializer.new(item)
      end

      def update
        render json: ItemSerializer.new(Item.update(params[:id], item_params))
      end

      def destroy
        item = Item.find(params[:id])
        item.destroy
      end

      private

      def item_params
        params.permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end
