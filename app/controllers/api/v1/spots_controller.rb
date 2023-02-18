# frozen_string_literal: true

module Api
  module V1
    class SpotsController < ApplicationController
      skip_before_action :authenticate_user, only: %i[index show]
      before_action :set_spot, only: %i[show update]
      before_action :spot_params, only: %i[create update]

      def index
        spots = Spot.order(:price).page(params[:page]).per(6)

        render json: { spots: spots, total_pages: spots.total_pages }, methods: %i[image_urls no_of_reviews],
               status: :ok
      end

      def show
        render json: @spot, status: :ok
      end

      def create
        @spot = @current_user.spots.build(spot_params)

        if @spot.save
          render json: @spot.to_json(include: :images), status: :ok
        else
          render json: { message: @spot.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @spot.update(spot_params)
          render json: @spot.to_json(include: :images), status: :ok
        else
          render json: { message: @spot.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_spot
        @spot = Spot.find_by(id: params[:id])

        return render json: { message: I18n.t('errors.messages.not_found') }, status: :not_found unless @spot
      end

      def spot_params
        params.permit(:title, :description, :price, images: [])
      end
    end
  end
end
