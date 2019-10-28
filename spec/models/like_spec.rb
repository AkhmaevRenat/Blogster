# frozen_string_literal: true

require 'rails_helper'

describe Like do
  describe 'assotiations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:likeable) }
  end
end
