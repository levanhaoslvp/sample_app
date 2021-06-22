FactoryBot.define do
  factory :user do
    sequence(:email) { |n| 'testtest#{n}@example.com' }
    password {'password12'}
    password_confirmation {'password12'}
    created_at {2.day.ago}
    confirmed_at {1.day.ago}
  end
end
