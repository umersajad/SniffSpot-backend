class AddUserToReview < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :user, null: true, foreign_key: true
  end
end
