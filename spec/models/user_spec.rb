# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Database table' do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:username).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end

  describe 'Associations' do
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_many(:spots).dependent(:destroy) }
  end

  describe 'has_secure_password' do
    it { should have_secure_password }
  end
end
