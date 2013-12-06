class Poll < ActiveRecord::Base
  attr_accessible :title, :author_id
  validates :title, :author_id, :presence => true

  has_many(
    :questions,
    :primary_key => :id,
    :foreign_key => :poll_id,
    :class_name => "Question"
  )

  belongs_to(
    :author,
    :primary_key => :id,
    :foreign_key => :author_id,
    :class_name => "User"
  )

end