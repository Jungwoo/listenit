class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :src_url
      t.string :cover_s_url
      t.string :cover_l_url
      t.string :description
      t.string :author
      t.string :publisher
      t.string :category
      t.string :status_des

      t.timestamps
    end
  end
end
