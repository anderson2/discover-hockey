class AddSummaryToPeople < ActiveRecord::Migration
  def change
    add_column :people, :summary, :text
  end
end
