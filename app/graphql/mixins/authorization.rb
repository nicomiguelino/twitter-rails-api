module Mixins::Authorization
  extend ActiveSupport::Concern

  included do
    def authorized?
      return !context[:current_user].nil?
    end
  end
end
