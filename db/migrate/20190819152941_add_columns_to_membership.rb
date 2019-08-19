class AddColumnsToMembership < ActiveRecord::Migration[5.0]
  def change
    add_column :memberships, :user_name, :string
    add_column :memberships, :group_name, :string
  end
end
