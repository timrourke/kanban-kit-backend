class Board < ApplicationRecord
  include ScopeColumnsSelectable

  belongs_to :project
  belongs_to :user
end
