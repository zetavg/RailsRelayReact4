Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  connection :posts do
    type Types::PostType.connection_type

    resolve -> (obj, args, ctx) {
      Post.all
    }
  end

  field :node, GraphQL::Relay::Node.field
end
