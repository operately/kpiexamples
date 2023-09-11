class KpiUpvote < ApplicationRecord
  belongs_to :user
  belongs_to :kpi
end
