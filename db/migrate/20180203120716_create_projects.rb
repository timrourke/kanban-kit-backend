class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :uuid do |t|
			t.string :title, null: false
			t.text   :description

			t.uuid   :user_id, null: false

      t.timestamps
    end
  end
end
