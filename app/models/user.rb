class User < ApplicationRecord
  validates :email, presence: true
  validates :name, presence: true
  validates :provider, presence: true
  validates :uid, presence: true

  has_many :kpi_upvotes
  has_many :upvoted_kpis, through: :kpi_upvotes, source: :kpi

  has_many :comments

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.avatar_url = auth.info.image
      user.save!
    end
  end
end
