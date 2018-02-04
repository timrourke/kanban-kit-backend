class Project < ApplicationRecord
  include ScopeColumnsSelectable

  belongs_to :user
  has_many   :boards
end
