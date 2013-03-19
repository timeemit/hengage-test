FactoryGirl.define do
  factory :user do
    email 'foo@bar.com'
    
    factory :admin do
      email 'admin@baz.com'
      admin true
    end
  end
end