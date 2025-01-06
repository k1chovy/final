class CreateFriends < ActiveRecord::Migration[8.0]
  def change
    create_table :friends do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :facebook

      t.timestamps
    end
  end
end
