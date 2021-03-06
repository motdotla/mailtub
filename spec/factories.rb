FactoryGirl.define do
  factory :raw_email do |f|
    f.sequence(:redis_key)      {|n| "#{(Time.now.to_i * 1000)}|#{n}"}
    f.source                    TEST_REDIS_VALUE 
  end
end
