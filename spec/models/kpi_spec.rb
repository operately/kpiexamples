require 'rails_helper'

RSpec.describe Kpi, type: :model do
  it { should belong_to(:subcategory) }

  describe "unit validation" do
    it "allows valid units" do
      kpi = build(:kpi, unit: 'money')
      expect(kpi).to be_valid
    end

    it "disallows invalid units" do
      kpi = build(:kpi, unit: 'oz')
      expect(kpi).not_to be_valid
    end
  end

  describe "description validation" do
    it "disallows blank" do
      kpi = build(:kpi, description: "")
      expect(kpi).not_to be_valid
    end
  end
end
