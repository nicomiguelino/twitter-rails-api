class Tweet < ApplicationRecord
  include Rails.application.routes.url_helpers
  include Content

  belongs_to :user
  has_many :comments, dependent: :destroy

  def url
    api_tweet_path(self)
  end
end
