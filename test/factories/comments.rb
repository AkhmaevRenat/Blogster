FactoryBot.define do
  factory :comment do
    user_id { 1 }
    body { "MyText" }
    article { nil }
  end
end
