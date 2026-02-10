class AddDriverToCarpool < ActiveRecord::Migration[6.0]
  def change
    add_column :carpools, :driver, :string
  end
end
