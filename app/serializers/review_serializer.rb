# frozen_string_literal: true

class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :username, :user_id

  def username
    object.user.username
  end
end
