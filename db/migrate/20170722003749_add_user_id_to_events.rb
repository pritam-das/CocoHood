class AddUserIdToEvents < ActiveRecord::Migration[5.1]
  # While the title is labelled as events, we have to add the user id column
  # to the plans table. Had to label as plans because there is an events option
  # for the calendar plugin and naming events as plans is to avoid confusion.
  def change
    add_column :plans, :user_id, :integer
  end
end
