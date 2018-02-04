require 'rails_helper'
require Rails.root.join 'spec/models/concerns/scope_columns_selectable_spec.rb'

include RSpec

describe User do
  it_behaves_like 'scope_columns_selectable'
end
