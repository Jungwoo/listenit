class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :book_id
      t.integer :related_entity_id
      t.string :comment

      t.timestamps
    end
  end
end
