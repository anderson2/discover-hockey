class AddRememberDigestToPeople < ActiveRecord::Migration
  def change
    add_column :people, :remember_digest, :string
  end
end
