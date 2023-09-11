require 'rails_helper'

RSpec.feature "KPI Upvoting", type: :feature, js: true do
  let!(:kpi) { create(:kpi) }

  before do
    visit root_path
    find('[data-testid="google-signin-btn"]').click
  end

  scenario "User can upvote a KPI" do
    visit category_kpi_path(kpi.category, kpi)

    expect(page).to have_button("👍 Upvote")

    click_on "👍 Upvote"

    expect(page).to have_button("👍 Upvoted")
  end

  context "when a KPI is already upvoted" do
    before do
      user = User.first
      user.upvoted_kpis << kpi
    end

    scenario "User can undo an upvote for a KPI" do
      visit category_kpi_path(kpi.category, kpi)

      expect(page).to have_button("👍 Upvoted")

      click_on "👍 Upvoted"

      expect(page).to have_button("👍 Upvote")
    end
  end
end

