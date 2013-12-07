class Response < ActiveRecord::Base
  attr_accessible :answer_choice_id, :respondent_id
  validates :respondent_id, :answer_choice_id, :presence => true
  validates :respondent_id, :uniqueness => { :scope => :answer_choice_id }
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_respond_to_own_poll
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

  private

  def author_cannot_respond_to_own_poll
    poll_objects = Poll.joins(:questions => :answer_choices)
    .where("polls.author_id = #{respondent_id}
    AND answer_choices.id = #{answer_choice_id}")

    if !poll_objects.empty?
      errors[:respondent_id] << "Can't answer own poll"
    end
  end

  def respondent_has_not_already_answered_question
    if !existing_responses.empty? ||
      (existing_responses.count == 1 &&
      existing_respsonses.id != self.id)
      errors[:respondent_id] << "Can't answer twice"
    end
  end

  def existing_responses
    options = { :answer_choice_id => self.answer_choice_id,
                :respondent_id => self.respondent_id
              }
    Response.find_by_sql([<<-SQL, options])
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