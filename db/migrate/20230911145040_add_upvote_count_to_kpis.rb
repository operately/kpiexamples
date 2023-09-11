class AddUpvoteCountToKpis < ActiveRecord::Migration[7.0]
  def change
    add_column :kpis, :upvote_count, :integer
  end
end
