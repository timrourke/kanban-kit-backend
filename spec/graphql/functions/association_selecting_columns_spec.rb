require 'rails_helper'

include RSpec

describe Functions::AssociationSelectingColumns do
  it 'initializes' do
    expectedAssociation = 'foo'
    expectedType = Types::UserType

    instance = Functions::AssociationSelectingColumns.new(
      association: expectedAssociation,
      type: expectedType
    )

    expect(instance).to be_an_instance_of(Functions::AssociationSelectingColumns)
  end

  it 'exposes the type' do
    expectedAssociation = 'foo'
    expectedType = Types::UserType

    instance = Functions::AssociationSelectingColumns.new(
      association: expectedAssociation,
      type: expectedType
    )

    expect(instance.type).to eq(expectedType) 
  end

  it 'calls the assocation method directly when context is null' do
    board = double(Board)

    instance = Functions::AssociationSelectingColumns.new(
      association: 'user',
      type: Types::UserType
    )

    allow(board).to receive(:user)

    instance.call(board, nil, nil)

    expect(board).to have_received(:user)
  end

  it 'returns a belongs_to without modifying query' do
    user = User.new
    board = Board.new(user: user)
    context_double = instance_double(GraphQL::Query::Context)
    instance = Functions::AssociationSelectingColumns.new(
      association: 'user',
      type: Types::UserType
    )

    expect(instance.call(board, nil, context_double)).to eq(user)
  end

  it 'selects only the columns in the query node context from the association' do
    board_double   = double(Board)
    user_double    = double(User)
    context_double = instance_double(GraphQL::Query::Context)
    node_double    = instance_double(GraphQL::InternalRepresentation::Node)

    instance = Functions::AssociationSelectingColumns.new(
      association: 'user',
      type: Types::UserType
    )

    # Configure board mock
    allow(board_double).to receive(:user).and_return(user_double)
    allow(user_double).to receive(:reflections).and_return({})

    # Configure context mock
    allow(context_double).to receive(:irep_node).and_return(node_double)

    # Configure user mock
    allow(user_double).to receive(:has_attribute?).and_return(true)
    allow(user_double).to receive(:class).and_return(user_double)
    allow(user_double).to receive(:selecting_columns).with([
      'foo_column',
      'bar_column',
      'baz_column'
    ])

    # Configure node mock
    allow(node_double).to receive(:scoped_children).and_return({0 => {
      'fooColumn' => nil,
      'barColumn' => nil,
      'bazColumn' => nil
    }})

    instance.call(board_double, nil, context_double)

    expect(board_double).to have_received(:user).exactly(4).times
    expect(user_double).to have_received(:selecting_columns).with([
      'foo_column',
      'bar_column',
      'baz_column'
    ])
  end

  it 'includes foreign keys' do
    board_double   = double(Board)
    user_double    = double(User)
    context_double = instance_double(GraphQL::Query::Context)
    node_double    = instance_double(GraphQL::InternalRepresentation::Node)
    ReflectionStub = Struct.new(:foreign_key)
    reflection_stub = ReflectionStub.new('another_related_id')

    instance = Functions::AssociationSelectingColumns.new(
      association: 'user',
      type: Types::UserType
    )

    # Configure board mock
    allow(board_double).to receive(:user).and_return(user_double)
    allow(user_double).to receive(:reflections).and_return({0 => reflection_stub})

    # Configure context mock
    allow(context_double).to receive(:irep_node).and_return(node_double)

    # Configure user mock
    allow(user_double).to receive(:has_attribute?).and_return(true)
    allow(user_double).to receive(:class).and_return(user_double)
    allow(user_double).to receive(:selecting_columns).with([
      'foo_column',
      'related_id',
      'another_related_id'
    ])

    # Configure node mock
    allow(node_double).to receive(:scoped_children).and_return({0 => {
      'fooColumn' => nil,
      'relatedId' => nil
    }})

    instance.call(board_double, nil, context_double)

    expect(board_double).to have_received(:user).exactly(4).times
    expect(user_double).to have_received(:selecting_columns).with([
      'foo_column',
      'related_id',
      'another_related_id'
    ])
  end
end
