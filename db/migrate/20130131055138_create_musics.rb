class CreateMusics < ActiveRecord::Migration
  def change
    create_table :musics do |t|
      t.string :title
      t.string :video_id
      t.string :url
      t.time :duration
      t.date :reg_date

      t.timestamps
    end
  end
end
