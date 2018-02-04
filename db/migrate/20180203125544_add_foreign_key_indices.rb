class AddForeignKeyIndices < ActiveRecord::Migration[5.1]
  def change
    add_index(:projects, :user_id)
    add_index(:boards, :project_id)
    add_index(:boards, :user_id)
  end
end
