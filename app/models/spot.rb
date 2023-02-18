# frozen_string_literal: true

class Spot < ApplicationRecord
  has_many_attached :images

  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true

  belongs_to :user
  has_many :reviews, dependent: :destroy

  def image_urls
    images.map(&:url)
  end

  def no_of_reviews
    reviews.count
  end
end
