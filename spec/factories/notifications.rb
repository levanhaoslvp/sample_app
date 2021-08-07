FactoryBot.define do
  factory :notification do
    user { nil }
    recipient_id { 1 }
    action { "comment" }
    notifiable { nil }
  end
end
