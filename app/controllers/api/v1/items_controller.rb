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
    end
  end
end
