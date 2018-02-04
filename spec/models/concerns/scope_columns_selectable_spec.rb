require 'rails_helper'

include RSpec

shared_examples_for 'scope_columns_selectable' do
  let(:model) { described_class }

  it 'selects columns' do
    columnsSelectable = model
    columns = ['foo', 'bar', 'baz']

    expect(columnsSelectable.selecting_columns(columns).arel.projections)
      .to eq columns
  end
end
