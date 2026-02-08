class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :street
      t.string :number
      t.string :district
      t.string :city
      t.string :CEP
      t.belongs_to :carpool, null: false, foreign_key: true

      t.timestamps
    end
  end
end
