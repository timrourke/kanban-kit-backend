Types::UserType = GraphQL::ObjectType.define do
  name "User"
	description "A User"
  field :email, !types.String
	field :created_at, !types.String do 
		resolve ->(obj, args, ctx) {
			obj["created_at"].iso8601
		}
	end
	field :updated_at, !types.String do 
		resolve ->(obj, args, ctx) {
			obj["updated_at"].iso8601
		}
	end
end
