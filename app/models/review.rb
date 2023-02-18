# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :user

  validates :content, presence: true, length: { maximum: 1000 }
end
