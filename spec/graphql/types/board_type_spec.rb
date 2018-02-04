require 'rails_helper'

include RSpec

describe Types::BoardType do
  it 'should format createdAt to ISO8601' do
    type = Types::BoardType
    date = Time.utc(2018, 'jan', 7, 4, 23, 11)
    board = Board.new(created_at: date)

    createdAt = type.fields['createdAt'].resolve(board, nil, nil)

    expect(createdAt).to eq '2018-01-07T04:23:11Z'
  end

  it 'should format updatedAt to ISO8601' do
    type = Types::BoardType
    date = Time.utc(2019, 'feb', 8, 10, 23, 55)
    board = Board.new(updated_at: date)

    updatedAt = type.fields['updatedAt'].resolve(board, nil, nil)

    expect(updatedAt).to eq '2019-02-08T10:23:55Z'
  end

  it 'should return the user' do
    type = Types::BoardType
    user = User.new
    board = Board.new(user: user)

    actualUser = type.fields['user'].resolve(board, nil, nil)

    expect(actualUser).to eq user
  end

  it 'should return the project' do
    type = Types::BoardType
    project = Project.new
    board = Board.new(project: project)

    actualProject = type.fields['project'].resolve(board, nil, nil)

    expect(actualProject).to eq project
  end
end
