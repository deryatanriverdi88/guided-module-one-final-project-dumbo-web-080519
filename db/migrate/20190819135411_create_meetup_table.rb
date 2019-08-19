class CreateMeetupTable < ActiveRecord::Migration[5.0]
  def change
    create_table :meetups do |t|
      t.integer :group_id
      t.string :location
      t.date :datetime
    end
  end
end
