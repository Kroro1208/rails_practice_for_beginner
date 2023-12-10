class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_description, :text
  end
end
