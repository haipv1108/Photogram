require 'faker'

FactoryGirl.define do
  factory :comment do |f|
    f.content { Faker::Lorem.sentence }
    association :user, factory: :user
    association :post, factory: :post
  end
end