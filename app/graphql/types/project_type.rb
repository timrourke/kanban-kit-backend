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

  field :user, Types::UserType do
    resolve ->(obj, args, ctx) {
      obj.user
    }
  end

  field :boards, Types::BoardType.to_list_type do
    resolve ->(obj, args, ctx) {
      byebug
      puts ctx.value.inspect
      obj.boards
    }
  end
end
