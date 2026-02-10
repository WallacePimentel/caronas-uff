class AddPricePerPersonToCarpool < ActiveRecord::Migration[6.0]
  def change
    add_column :carpools, :price_per_person, :float
  end
end
