require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.user_name { Faker::Lorem.characters(10) }
    f.email { Faker::Internet.email }
    f.password "password"
  end
end