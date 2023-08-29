require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe "POST /notifications" do
    let(:category) { create(:category) }

    let(:valid_attributes) {
      { notification: { email: "test@example.com", category_id: category.id } }
    }

    let(:invalid_attributes) {
      { notification: { email: "invalid-email", category_id: category.id } }
    }

    context "with valid parameters" do
      it "creates a new Notification" do
        expect {
          post notifications_path, params: valid_attributes
        }.to change(Notification, :count).by(1)
      end

      it "redirects to the category path" do
        post notifications_path, params: valid_attributes
        expect(response).to redirect_to(category_path(category))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Notification" do
        expect {
          post notifications_path, params: invalid_attributes
        }.not_to change(Notification, :count)
      end

      it "renders the category page with form" do
        post notifications_path, params: invalid_attributes
        expect(response.body).to include("Leave your email")
      end
    end
  end
end
