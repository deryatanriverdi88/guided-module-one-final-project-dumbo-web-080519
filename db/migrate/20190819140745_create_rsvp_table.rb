class CreateRsvpTable < ActiveRecord::Migration[5.0]
  def change
    create_table :rsvps do |t|
      t.integer :user_id
      t.integer :meetup_id
    end
  end
end
