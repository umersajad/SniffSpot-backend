class AddUserToSpot < ActiveRecord::Migration[7.0]
  def change
    add_reference :spots, :user, null: true, foreign_key: true
  end
end
