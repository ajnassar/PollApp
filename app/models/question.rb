class Question < ActiveRecord::Base
  attr_accessible :poll_id, :text
  validates :poll_id, :text, :presence => true

  has_many(
    :answer_choices,
    :primary_key => :id,
    :foreign_key => :question_id,
    :class_name => "AnswerChoice"
  )

  belongs_to(
    :poll,
    :primary_key => :id,
    :foreign_key => :poll_id,
    :class_name => "Poll"
  )

  def results
    answer_hash = {}
    answers = AnswerChoice.includes(:responses)
    .where("answer_choices.question_id = #{self.id}")

    answers.each do |answer|
      answer_hash[answer.text] = answer.responses.length
    end
    answer_hash
  end

end