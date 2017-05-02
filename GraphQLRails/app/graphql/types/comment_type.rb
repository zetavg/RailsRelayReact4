Types::CommentType = GraphQL::ObjectType.define do
  name "Comment"
  field :content, types.String
end
