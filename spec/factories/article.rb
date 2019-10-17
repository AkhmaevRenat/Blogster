# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'Article title' }
    text { 'Article text' }
  end
end
