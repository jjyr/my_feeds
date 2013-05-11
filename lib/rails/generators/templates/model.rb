class Feed < ActiveRecord::Base
  attr_accessible :source_id, :source_type, :event, :target_id, :target_type

  #verify event uniqueness, you can remove this
  validates :event, uniqueness: {scope: [:source_id, :source_type, :target_id, :target_type]}, :if => :target_id

  belongs_to :source, polymorphic: true
  belongs_to :target, polymorphic: true
end
