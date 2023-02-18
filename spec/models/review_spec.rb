# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Database table' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:content).of_type(:string) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:spot_id).of_type(:integer) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:spot) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:spot_id) }
  end
end
