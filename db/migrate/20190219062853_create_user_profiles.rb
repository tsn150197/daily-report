class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.string :avatar_url
      t.boolean :gender
      t.date :birthday
      t.string :address
      t.string :phone
      t.integer :user_id

      t.timestamps
    end
  end
end
