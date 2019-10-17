# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Renatik' }
    email { 'renatik123@mail.ru' }
    password { 'qweqweqwe' }
    age { 18 }
  end
end
