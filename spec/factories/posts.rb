FactoryBot.define do
  factory :post do
    title {'my title'}
    content {'my content'}
    created_at {2.day.ago}
    image {'https://theme.hstatic.net/1000260507/1000683850/14/hbanner_img1.png?v=45'}

    trait :no_title do
      title {''}
    end

    trait :no_content do
      content {''}
    end

    trait :no_image do
      image {''}
    end

    trait :no_user do
      user {nil}
    end

    factory :post_no_title, traits: [:no_title]
    factory :post_no_content, traits: [:no_content]
    factory :post_no_image, traits: [:no_image]
    factory :post_no_user, traits: [:no_user] 
  end
end
