FactoryBot.define do
  factory :user do
    sequence(:email) {|n| sprintf('taro%d@example.com', n) }
    sequence(:name) {|n| sprintf('Taro%d', n) }
    password { 'password' }
  end
end