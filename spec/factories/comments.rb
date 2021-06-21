FactoryBot.define do
  factory :comment do
    content {'my content'}

    trait :no_content do
      content {''}
    end

    factory :comment_no_content, traits: [:no_content]
  end
end
