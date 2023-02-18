# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_user

  private

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  end
end
