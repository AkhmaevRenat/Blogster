# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { 'HI' }

    factory :second_comment do
      body { 'Hi and hi' }
    end
  end
end
