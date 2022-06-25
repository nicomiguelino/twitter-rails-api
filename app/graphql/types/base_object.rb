module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField

    def authorize
      if context[:current_user].nil?
        raise GraphQL::ExecutionError.new(
          "You don't have enough permissions.",
          extensions: { status: 401 }
        )
      end
    end
  end
end
