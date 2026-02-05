class AddStatusToCampus < ActiveRecord::Migration[6.0]
  def change
    add_column :campus, :status, :integer, default: 0, null: false
  end
end
