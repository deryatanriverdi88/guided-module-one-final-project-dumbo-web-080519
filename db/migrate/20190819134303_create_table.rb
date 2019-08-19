class CreateTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :location
      t.integer :age
    end
  end
end
