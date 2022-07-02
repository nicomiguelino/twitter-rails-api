class Tweet < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, length: { in: 1..280 }

  def url
    api_tweet_path(self)
  end
end
