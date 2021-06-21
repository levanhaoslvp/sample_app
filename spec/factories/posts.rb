FactoryBot.define do
  factory :post do
    title {'my title'}
    content {'my content'}
    image {'https://vcdn-thethao.vnecdn.net/2021/06/20/1-2426-1624149210.jpg'}

    trait :no_title do
      title {''}
    end

    trait :no_content do
      content {''}
    end

    trait :no_image do
      image {''}
    end

    factory :post_no_title, traits: [:no_title]
    factory :post_no_content, traits: [:no_content]
    factory :post_no_image, traits: [:no_image] 
  end
end
