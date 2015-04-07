FactoryGirl.define do
  factory :guest do
    reservation
    sequence(:name) { |n| "Name#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    state "attend_both"
  end

end
