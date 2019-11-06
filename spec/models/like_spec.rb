# frozen_string_literal: true

require 'rails_helper'

describe Like do
  it { is_expected.to have_db_column(:likeable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:likeable_type).of_type(:string) }

  describe 'assotiations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:likeable) }
  end
end
