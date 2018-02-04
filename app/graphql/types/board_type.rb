Types::BoardType = GraphQL::ObjectType.define do
  name "Board"
  description "A kanban board"

  field :id, !types.String
  field :title, !types.String
  field :description, types.String

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

  field :project, function:
    Functions::AssociationSelectingColumns.new(
      association: 'project',
      type: Types::ProjectType
    )
end
