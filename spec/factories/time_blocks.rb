# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :time_block do
    start_time "2013-03-20 13:10:20"
    end_time "2013-03-20 13:20:20"
    user
    project
  end
end
