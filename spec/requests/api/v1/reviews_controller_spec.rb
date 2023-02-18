# frozen_string_literal: true

require 'rails_helper'
include JsonWebToken

RSpec.describe Api::V1::ReviewsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:spot) { FactoryBot.create(:spot) }
  let(:review) { FactoryBot.create(:review, spot: spot, user: user) }
  let(:valid_params) { { content: 'This a test spec', spot_id: spot.id } }

  before do
    token = JsonWebToken.jwt_encode({ user_id: user.id })
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates the review object' do
        post :create, params: valid_params
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['content']).to eq('This a test spec')
        expect(JSON.parse(response.body)['user_id']).to eq(user.id)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity' do
        post :create, params: { spot_id: spot.id, content: nil }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Failed to create review.')
      end

      it 'returns not found if the spot does not exist' do
        post :create, params: { spot_id: 999, content: 'not found' }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('Spot not found')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the review' do
        put :update, params: { id: review.id, spot_id: spot.id, content: 'New content' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Review was successfully updated.')
        expect(review.reload.content).to eq('New content')
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity' do
        put :update, params: { id: review.id, content: nil }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Failed to update review.')
      end
    end
  end
end
