# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    user_id { 1 }
    title { 'MyString' }
    text { 'MyText' }
  end
end
