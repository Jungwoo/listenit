class Relation < ActiveRecord::Base
  belongs_to :book, :foreign_key => "book_id", :class_name => "Book"
  belongs_to :relation, :foreign_key =>"related_entity_id", :class_name => "Book"
  belongs_to :user
end
