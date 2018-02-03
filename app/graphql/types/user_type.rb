Types::UserType = GraphQL::ObjectType.define do
  name "User"
	description "A User"

	field :id, !types.String

  field :email, !types.String

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
end
