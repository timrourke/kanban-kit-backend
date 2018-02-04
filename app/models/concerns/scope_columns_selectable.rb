module ScopeColumnsSelectable
  extend ActiveSupport::Concern

  included do
    scope :selecting_columns, ->(columns) { select(columns) }
  end
end
