require 'rails_helper'

RSpec.describe CommentsController, type: :request do

  describe "POST #create" do

    let(:category) { create(:category) }
    let(:kpi) { create(:kpi, category: category) }
    let(:comment_params) do
      {
        comment: {
          content: "Test comment",
          commentable_id: kpi.id,
          commentable_type: kpi.class.name
        },
        return_path: category_kpi_path(category, kpi)
      }
    end

    context "when the user is not logged in" do

      it "does not create a comment" do
        expect do
          post comments_path, params: comment_params
        end.not_to change(Comment, :count)
      end

      it "responds with redirect to homepage" do
        post comments_path, params: comment_params
        expect(response).to redirect_to(root_path)
      end
    end

    context "when the user is logged in" do

      before do
        login_with_oauth
      end

      it 'creates a comment' do
        expect do
          post comments_path, params: comment_params
        end.to change(Comment, :count).by(1)
      end

      it 'responds with a turbo stream and successful status' do
        post comments_path, params: comment_params, headers: { "Accept" => "text/vnd.turbo-stream.html" }
        expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
