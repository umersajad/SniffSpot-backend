# frozen_string_literal: true

require 'rails_helper'
include JsonWebToken

RSpec.describe Api::V1::SpotsController, type: :controller do
  let!(:spot1) { FactoryBot.create(:spot) }
  let!(:spot2) { FactoryBot.create(:spot) }
  let!(:spots) { FactoryBot.create_list(:spot, 10) }
  let!(:user)  { FactoryBot.create(:user) }
  let(:valid_params) { { title: 'Test Spot', description: 'Test description', price: 10 } }
  let(:spot_params) { attributes_for(:spot) }

  describe 'GET #index' do
    let(:params) { { page: 1 } }

    before do
      allow(controller).to receive(:params).and_return(params)
    end

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns spots total pages' do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['spots']).to be_present
      expect(parsed_response['total_pages']).to eq(2)
    end

    it 'returns the correct number of spots per page' do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['spots'].size).to eq(6)
      expect(parsed_response['total_pages']).to eq(2)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response with the correct spot' do
      get :show, params: { id: spot1.id }
      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to eq(spot1.id)
      expect(parsed_response['title']).to eq(spot1.title)
      expect(parsed_response['description']).to eq(spot1.description)
      expect(parsed_response['price']).to eq(spot1.price)
    end

    it 'returns a not found response when the spot does not exist' do
      get :show, params: { id: 'invalid_id' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe '#update' do
    context 'when the user is authorized' do
      before do
        token = JsonWebToken.jwt_encode({ user_id: user.id })
        request.headers['Authorization'] = "Bearer #{token}"
        patch :update, params: { id: spot1.id, title: 'Updated title', description: 'Updated description' }
      end

      it 'returns HTTP success' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the spot' do
        spot1.reload
        expect(spot1.title).to eq('Updated title')
        expect(spot1.description).to eq('Updated description')
      end
    end

    context 'when the user is not authorized' do
      let!(:unauthorized_user) { FactoryBot.create(:user) }

      before do
        token = JsonWebToken.jwt_encode({ user_id: unauthorized_user.id })
        request.headers['Authorization'] = "Bearer #{token}"
        patch :update, params: { id: spot1.id, title: '' }
      end

      it 'returns HTTP unauthorized' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the spot' do
        spot1.reload
        expect(spot1.title).not_to eq('Updated Spot')
        expect(spot1.description).not_to eq('Updated description')
      end
    end
  end

  describe '#create' do
    context 'with valid spot params' do
      before do
        token = JsonWebToken.jwt_encode({ user_id: user.id })
        request.headers['Authorization'] = "Bearer #{token}"
        post :create, params: valid_params
      end

      it 'returns HTTP success' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
