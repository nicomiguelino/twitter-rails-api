class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :content, length: { in: 1..280 }
end
