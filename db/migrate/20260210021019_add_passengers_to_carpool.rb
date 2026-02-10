class AddPassengersToCarpool < ActiveRecord::Migration[6.0]
  def change
    add_column :carpools, :passengers, :integer
  end
end
