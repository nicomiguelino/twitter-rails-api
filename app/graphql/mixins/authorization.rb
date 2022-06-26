module Mixins::Authorization
  extend ActiveSupport::Concern

  included do
    def is_logged_in
      !context[:current_user].nil?
    end
    def authorized?(object = nil, args = nil, ctx = nil)
      is_logged_in
    end
  end
end
