class AddDepartureTimeToCarpool < ActiveRecord::Migration[6.0]
  def change
    add_column :carpools, :departure_time, :datetime
  end
end
