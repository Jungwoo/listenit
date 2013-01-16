class AddUserIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :user_id, :integer, :references => "User"
    add_column :relations, :user_id, :integer, :references => "User"
  end
end
