class Book < ActiveRecord::Base
  has_many :relations_association, :class_name => "Relation"
  has_many :relations, :through => :relations_association, :source => :relation
  has_many :inverse_relations_association, :class_name => "Relation", :foreign_key => "related_entity_id"
  has_many :inverse_relations_association, :through => :inverse_relations_association, :source => :book
  belongs_to :user
end