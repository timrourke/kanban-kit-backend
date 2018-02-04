# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{ email: 'tim@timrourke.com' }])
projects = Project.create([
	{
		title: 'First project',
		description: 'This is a description',
		user: users.first
	},
	{
		title: 'Second project',
		description: 'This is a description',
		user: users.first
	},
	{
		title: 'Third project',
		description: 'This is a description',
		user: users.first
	}
])
Board.create([
	{
		title: 'First board',
		description: 'This is a description',
		user: users.first,
		project: projects.first
	},
	{
		title: 'Second board',
		description: 'This is a description',
		user: users.first,
		project: projects.first
	},
	{
		title: 'Third board',
		description: 'This is a description',
		user: users.first,
		project: projects.first
	},
	{
		title: 'Fourth board',
		description: 'This is a description',
		user: users.first,
		project: projects[1]
	},
	{
		title: 'Fifth board',
		description: 'This is a description',
		user: users.first,
		project: projects[1]
	},
	{
		title: 'Sixth board',
		description: 'This is a description',
		user: users.first,
		project: projects[2]
	},
	{
		title: 'Seventh board',
		description: 'This is a description',
		user: users.first,
		project: projects[2]
	},
]);
