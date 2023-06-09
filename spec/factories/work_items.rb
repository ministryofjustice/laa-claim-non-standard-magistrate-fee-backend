FactoryBot.define do
  factory :work_item do
    id { SecureRandom.uuid }

    trait :valid do
      work_type { WorkTypes.values.sample.to_s }
      time_spent { 100 }
      completed_on { Date.yesterday }
      fee_earner { 'jimbob' }
    end

    trait :partial do
      work_type { WorkTypes.values.sample.to_s }
      time_spent { 100 }
    end

    WorkTypes.values.each do |value|
      trait value.to_s.to_sym do
        work_type { value.to_s }
      end
    end
  end
end
