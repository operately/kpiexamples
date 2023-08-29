require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:category) { create(:category) }

  subject { build(:notification, category: category) }

  it { should belong_to(:category) }

  it { should validate_presence_of(:email) }

  it "should validate allowance of one email per category" do
    subject.save
    duplicate_notification = Notification.new(email: subject.email, category: category)
    expect(duplicate_notification).not_to be_valid
  end

  it "should validate email format" do
    valid_notification = Notification.new(email: 'test@example.com', category: category)
    invalid_notification = Notification.new(email: 'invalid_email', category: category)

    expect(valid_notification).to be_valid
    expect(invalid_notification).not_to be_valid
  end
end
