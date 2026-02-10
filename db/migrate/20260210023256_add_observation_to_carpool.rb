class AddObservationToCarpool < ActiveRecord::Migration[6.0]
  def change
    add_column :carpools, :observation, :string
  end
end
