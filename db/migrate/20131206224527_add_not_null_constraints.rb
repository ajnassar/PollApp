class AddNotNullConstraints < ActiveRecord::Migration

  def change
    change_column(:users, :name, :string, :null => false)
    change_column(:polls, :title, :string, :null => false)
    change_column(:polls, :author_id, :integer, :null => false)
    change_column(:questions, :poll_id, :integer, :null => false)
    change_column(:questions, :text, :text, :null => false)
    change_column(:answer_choices, :question_id, :integer, :null => false)
    change_column(:answer_choices, :text, :text, :null => false)
    change_column(:responses, :respondent_id, :integer, :null => false)
    change_column(:responses, :answer_choice_id, :integer, :null => false)
  end

end
