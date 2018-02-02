Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

	field :user do
		type Types::UserType
		argument :id, !types.String
		description "Find a User by ID"

		resolve ->(obj, args, ctx) {
			User.find(args["id"])
		}
	end
end
