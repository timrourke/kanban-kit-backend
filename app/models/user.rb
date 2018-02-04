class User < ApplicationRecord
  include ScopeColumnsSelectable

  has_many :projects
end
