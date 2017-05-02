Types::PostType = GraphQL::ObjectType.define do
  name "Post"
  implements GraphQL::Relay::Node.interface
  global_id_field :id

  field :title, types.String
  field :content, types.String
  connection :comments, Types::CommentType.connection_type
end
