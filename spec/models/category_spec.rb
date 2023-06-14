require 'rails_helper'

RSpec.describe Category, type: :model do
  it "validates presence of name" do
    expect(build(:category, name: "")).to_not be_valid
  end
end
