class AddLoginToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :login, :string
    add_index  :keys, :login
  end
end
