# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# (1..10).each do |user|
#   User.create!({ :name => "User#{user}" })
# end
ActiveRecord::Base.transaction do
  (1..5).each do |poll|
    Poll.create!({ :title => "Poll title #{poll}", :author_id => poll })
  end

  (1..5).each do |poll|
    (1..3).each do |question|
      Question.create!({
        :poll_id => poll,
        :text => "Poll #{poll}: Question #{question}"
      })
    end
  end

  (1..15).each do |question|
    (1..3).each do |answer_choice|
      AnswerChoice.create!({
        :question_id => question,
        :text => "Question #{question}: AnswerChoice #{answer_choice}"
      })
    end
  end
end