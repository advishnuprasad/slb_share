# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    title "MyString"
    description "MyText"
    links "http://example.com"
    user { FactoryGirl.create(:user) }
  end

  factory :user do |user|
    user.email                  "#{Time.now.usec + Random.rand(10000)}-user@example.com"
    user.password               "password"
    user.password_confirmation  "password"
  end
end

  