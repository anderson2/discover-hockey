class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.references :person, index: true

      t.timestamps null: false
    end
    add_index :posts, [:person_id, :created_at]
    
    #add_foreign_key :posts, :people
    
  end
end
