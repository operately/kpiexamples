require 'rails_helper'

RSpec.describe KpisController, type: :request do
  let!(:category) { create(:category) }
  let!(:kpi) { create(:kpi, category: category) }

  describe 'POST #upvote' do
    context 'when user is not logged in' do
      it 'does not change the upvote count' do
        expect {
          post upvote_category_kpi_path(category, kpi), params: { dom_id: "some_dom_id" }
        }.not_to change { kpi.reload.upvote_count }
      end
    end

    context 'when user is logged in' do
      before do
        login_with_oauth
      end

      it 'increments the upvote count' do
        post upvote_category_kpi_path(category, kpi), params: { dom_id: "some_dom_id" }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(kpi.reload.upvote_count).to eql(1)
      end
    end
  end

  describe 'POST #downvote' do
    context 'when user is not logged in' do
      it 'does not change the upvote count' do
        expect {
          delete downvote_category_kpi_path(category, kpi), params: { dom_id: "some_dom_id" }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        }.not_to change { kpi.reload.upvote_count }
      end
    end

    context 'when user is logged in' do
      before do
        login_with_oauth

        kpi.upvote_by!(User.last)
      end

      it 'decrements the upvote count' do
        expect(kpi.upvote_count).to eql(1)
        delete downvote_category_kpi_path(category, kpi), params: { dom_id: "some_dom_id" }, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(kpi.reload.upvote_count).to eql(0)
      end
    end
  end
end

