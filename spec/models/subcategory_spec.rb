require 'rails_helper'

RSpec.describe Subcategory, type: :model do
  it { should belong_to(:category) }
  it { should have_many(:kpis) }
end
