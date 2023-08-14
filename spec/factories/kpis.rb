FactoryBot.define do
  factory :kpi do
    name { "Example KPI" }
    category
    subcategory
    unit { "money" }
    description { "Example Description" }
    formula { "Example Formula" }
    example { "Example Example" }
  end
end
