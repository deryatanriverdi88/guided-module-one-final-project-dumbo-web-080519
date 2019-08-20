class RemoveAndAddColumnsToMeetups < ActiveRecord::Migration[5.0]
  def change
    change_table :meetups do |t|
      t.remove :datetime
      t.date :date
      t.time :time
    end
  end
end
