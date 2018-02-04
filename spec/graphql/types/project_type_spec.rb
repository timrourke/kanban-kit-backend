require 'rails_helper'

include RSpec

describe Types::ProjectType do
  it 'should format createdAt to ISO8601' do
    type = Types::ProjectType
    date = Time.utc(2018, 'jan', 7, 4, 23, 11)
    project = Project.new(created_at: date)

    createdAt = type.fields['createdAt'].resolve(project, nil, nil)

    expect(createdAt).to eq '2018-01-07T04:23:11Z'
  end

  it 'should format updatedAt to ISO8601' do
    type = Types::ProjectType
    date = Time.utc(2019, 'feb', 8, 10, 23, 55)
    project = Project.new(updated_at: date)

    updatedAt = type.fields['updatedAt'].resolve(project, nil, nil)

    expect(updatedAt).to eq '2019-02-08T10:23:55Z'
  end

  it 'should return the user' do
    type = Types::ProjectType
    user = User.new
    project = Project.new(user: user)

    actualUser = type.fields['user'].resolve(project, nil, nil)

    expect(actualUser).to eq user
  end

  it 'should return the boards' do
    type = Types::ProjectType
    boards = [Board.new, Board.new, Board.new]
    project = Project.new(boards: boards)

    actualBoards = type.fields['boards'].resolve(project, nil, nil)

    expect(actualBoards).to eq boards
  end
end
