require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_many(:subcategories) }
  it { should have_many(:kpis).through(:subcategories) }

  it "validates presence of name" do
    expect(build(:category, name: "")).to_not be_valid
  end
end
