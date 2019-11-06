# frozen_string_literal: true

require 'rails_helper'

describe Following do
  it { is_expected.to have_db_column(:user_id).of_type(:integer) }
  it { is_expected.to have_db_column(:followed_user_id).of_type(:integer) }

  describe 'assotiations' do
    it { is_expected.to belong_to(:user) }
  end
end
