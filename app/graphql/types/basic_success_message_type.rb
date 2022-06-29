# frozen_string_literal: true

module Types
  class BasicSuccessMessageType < Types::BaseObject
    field :message, String, null: false
  end
end
