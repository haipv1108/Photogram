require 'faker'

FactoryGirl.define do
  factory :post do |f|
    f.caption { Faker::Lorem.sentence(3)}
    f.image { Faker::Avatar.image("my-own-slug", "50x50", "jpg")}
    association :user, factory: :user
  end

  factory :invalid_post, parent: :post do |f|
    f.caption "aa"
  end
end