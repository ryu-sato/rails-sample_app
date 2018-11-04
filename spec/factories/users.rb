FactoryBot.define do
  factory :user do
    sequence(:name)  {|n| "User #{n}"}
    sequence(:email) {|n| "user-#{n}@example.com"}
    password         { 'password' }
    password_digest  { User.digest('password') }
    activated        { true }
  end
end
