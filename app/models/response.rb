class Response < ActiveRecord::Base
  attr_accessible :answer_choice_id, :respondent_id
  validates :respondent_id, :answer_choice_id, :presence => true
  validates :respondent_id, :uniqueness => { :scope => :answer_choice_id }

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

  #private
  def existing_responses
    Response.find_by_sql(<<-SQL, :answer_choice_id => self.answer_choice_id, :respondent_id = self.respondent_id )
      SELECT
        responses.*
      FROM
        responses
      JOIN
        answer_choices
      ON
        responses.answer_choice_id = answer_choices.id
      WHERE
        responses.respondent_id = :respondent_id
        AND
        answer_choices.question_id =
        (
        SELECT
          answer_choices.question_id
        FROM
          answer_choices
        WHERE
          answer_choices.id = :answer_choice_id
        )
      SQL
  end
end