# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :spots, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
