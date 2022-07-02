class Comment < ApplicationRecord
  include Content

  belongs_to :tweet
  belongs_to :user
end
