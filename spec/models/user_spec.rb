# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'assotiations' do
    it { is_expected.to have_many(:articles) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:likes) }
  end
end
