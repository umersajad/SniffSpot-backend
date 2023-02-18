# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Spot, type: :model do
  let(:spot)   { FactoryBot.create(:spot, price: 300) }
  let!(:spot1) { FactoryBot.create(:spot, price: 100) }
  let!(:spot2) { FactoryBot.create(:spot, price: 200) }
  let!(:spot3) { FactoryBot.create(:spot, price: 50) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many_attached(:images) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
  end

  describe 'database columns' do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:string) }
    it { should have_db_column(:price).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_index(:user_id) }
  end
end
