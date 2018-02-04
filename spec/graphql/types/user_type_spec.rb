require 'rails_helper'

include RSpec

describe Types::UserType do
  it 'should format createdAt to ISO8601' do
    type = Types::UserType
    date = Time.utc(2018, 'jan', 7, 4, 23, 11)
    user = User.new(created_at: date)

    createdAt = type.fields['createdAt'].resolve(user, nil, nil)

    expect(createdAt).to eq '2018-01-07T04:23:11Z'
  end

  it 'should format updatedAt to ISO8601' do
    type = Types::UserType
    date = Time.utc(2019, 'feb', 8, 10, 23, 55)
    user = User.new(updated_at: date)

    updatedAt = type.fields['updatedAt'].resolve(user, nil, nil)

    expect(updatedAt).to eq '2019-02-08T10:23:55Z'
  end

  it 'should return the projects' do
    type = Types::UserType
    projects = [Project.new, Project.new, Project.new]
    user = User.new(projects: projects)

    actualProject = type.fields['projects'].resolve(user, nil, nil)

    expect(actualProject).to eq projects
  end
end
