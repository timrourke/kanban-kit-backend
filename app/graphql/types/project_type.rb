Types::ProjectType = GraphQL::ObjectType.define do
  name "Project"
  description "A Project"

  field :id,          !types.String
  field :title,       !types.String
  field :description, !types.String

  field :createdAt, !types.String do 
    resolve ->(obj, args, ctx) {
      obj.created_at.iso8601
    }
  end

  field :updatedAt, types.String do 
    resolve ->(obj, args, ctx) {
      obj.updated_at.iso8601
    }
  end

  field :user, function:
    Functions::AssociationSelectingColumns.new(
      association: 'user',
      type: Types::UserType
    )

  field :boards, function:
    Functions::AssociationSelectingColumns.new(
      association: 'boards',
      type: Types::BoardType.to_list_type
    )
end
