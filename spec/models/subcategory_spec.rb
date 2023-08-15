require 'rails_helper'

RSpec.describe Subcategory, type: :model do
  it { should belong_to(:category) }
  it { should have_many(:kpis) }

  it "validates presence of name" do
    expect(build(:subcategory, name: "")).to_not be_valid
  end
end
