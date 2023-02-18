# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authenticate_user

      def login
        user = User.find_by_email(params[:email])

        if user&.authenticate(params[:password])
          token = jwt_encode(user_id: user.id)
          render json: user.as_json(only: %i[username email id]).merge({ token: token })
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      private

      def registration_params
        params.permit(:username, :email, :password)
      end
    end
  end
end
