class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.integer :user_id
      t.string :token
      t.string :remember_token

      t.timestamps
    end
  end
end
