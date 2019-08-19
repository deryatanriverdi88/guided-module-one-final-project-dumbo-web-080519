class CreateGroupTable < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :title
      t.string :category
      t.string :description
    end
  end
end
