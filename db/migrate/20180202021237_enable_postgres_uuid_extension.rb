class EnablePostgresUuidExtension < ActiveRecord::Migration[5.1]
  def change
		enable_extension 'pgcrpyto'
  end
end
