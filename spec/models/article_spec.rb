# frozen_string_literal: true

require 'rails_helper'
require 'models/concerns/likeable_spec'

describe Article do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'assotiations' do
    it { is_expected.to have_many(:comments) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:likes) }
  end

  it_behaves_like 'likeable'
end
