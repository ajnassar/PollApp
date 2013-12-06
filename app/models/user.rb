class User < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true

  has_many(
    :authored_polls,
    :primary_key => :id,
    :foreign_key => :author_id,
    :class_name => "Poll"
  )

  has_many(
    :responses,
    :primary_key => :id,
    :foreign_key => :respondent_id,
    :class_name => "Response"
  )

  has_many(
    :chosen_answers,
    :through => :responses,
    :source => :answer_choice
  )

  has_many(
    :answered_questions,
    :through => :chosen_answers,
    :source => :question
  )

end
