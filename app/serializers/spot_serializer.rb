# frozen_string_literal: true

class SpotSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :image_urls, :user_id

  has_many :reviews, serializer: ReviewSerializer, if: -> { object.reviews.any? }

  def reviews
    object.reviews.order(created_at: :desc).limit(5)
  end
end
