class AddTeamToPeople < ActiveRecord::Migration
  def change
    add_column :people, :team, :string
  end
end
