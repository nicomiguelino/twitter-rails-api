module Mixins::Authorization
  extend ActiveSupport::Concern

  included do
    def authorized?(object = nil, args = nil, ctx = nil)
      return !context[:current_user].nil?
    end
  end
end
