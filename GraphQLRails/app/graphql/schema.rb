Schema = GraphQL::Schema.define do
  query(Types::QueryType)

  # Relay Object Identification:

  # Return a string UUID for `object`
  id_from_object ->(object, type_definition, query_ctx) {
    # Here's a simple implementation which:
    # - joins the type name & object.id
    # - encodes it with base64:
    GraphQL::Schema::UniqueWithinType.encode(type_definition.name, object.id)
  }

  # Given a string UUID, find the object
  object_from_id ->(id, query_ctx) {
    # For example, to decode the UUIDs generated above:
    type_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)
    #
    # Then, based on `type_name` and `id`
    # find an object in your application
    Object.const_get(type_name).find(item_id)
  }

  # Object Resolution
  resolve_type -> (obj, ctx) {
    case obj
    when Post
      Types::PostType
    when Comment
      Types::CommentType
    else
      raise("Unexpected object: #{obj}")
    end
  }

  # GraphQL::Batch setup:
  lazy_resolve(Promise, :sync)
  instrument(:query, GraphQL::Batch::Setup)
end
