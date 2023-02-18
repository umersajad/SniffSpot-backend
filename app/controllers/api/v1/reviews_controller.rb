# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < ApplicationController
      before_action :set_spot, only: %i[create]
      before_action :review_params, only: %i[create]
      before_action :set_review, only: %i[update]

      def create
        review = @spot.reviews.build(review_params)
        review.user = @current_user

        if review.save
          render json: review, status: :ok
        else
          render json: { error: I18n.t('errors.messages.not_create') }, status: :unprocessable_entity
        end
      end

      def update
        if @review.update(review_params)
          render json: @review, status: :ok
        else
          render json: { error: I18n.t('errors.messages.not_update') }, status: :unprocessable_entity
        end
      end

      private

      def set_review
        @review = Review.find_by(id: params[:id])
        return if @review

        render json: { message: I18n.t('errors.messages.not_found') }, status: :not_found
      end

      def set_spot
        @spot = Spot.find_by(id: params[:spot_id])

        render json: { message: I18n.t('errors.messages.not_found') }, status: :not_found unless @spot
      end

      def review_params
        params.permit(:content)
      end
    end
  end
end
