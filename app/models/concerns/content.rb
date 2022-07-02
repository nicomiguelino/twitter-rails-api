module Content
  extend ActiveSupport::Concern

  MAX_CONTENT_LENGTH = 280

  included do
    validates :content, length: { in: 1..MAX_CONTENT_LENGTH }
  end
end
