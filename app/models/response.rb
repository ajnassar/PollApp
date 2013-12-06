class Response < ActiveRecord::Base
  attr_accessible :answer_choice_id, :respondent_id

  belongs_to(
    :respondent,
    :primary_key => :id,
    :foreign_key => :respondent_id,
    :class_name => "User"
  )

  belongs_to(
    :answer_choice,
    :primary_key => :id,
    :foreign_key => :answer_choice_id,
    :class_name => "AnswerChoice"
  )


end