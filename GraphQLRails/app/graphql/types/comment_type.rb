Types::CommentType = GraphQL::ObjectType.define do
  name "Comment"
  implements GraphQL::Relay::Node.interface
  global_id_field :id

  field :content, types.String
end
