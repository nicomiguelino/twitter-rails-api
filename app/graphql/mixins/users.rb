module Mixins::Users
  extend ActiveSupport::Concern

  included do
    def get_user_by_id(id)
      begin
        User.find(id)
      rescue StandardError => e
        raise GraphQL::ExecutionError.new(
          e.message, extensions: { status: 400 }
        )
      end
    end
  end
end
