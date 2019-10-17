# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  it { is_expected.to validate_presence_of(:body) }

  it { is_expected.to validate_presence_of(:article) }

  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to have_many(:likes) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to belong_to(:article) }
end
