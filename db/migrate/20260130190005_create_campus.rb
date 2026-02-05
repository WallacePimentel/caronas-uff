class CreateCampus < ActiveRecord::Migration[6.0]
  def change
    create_table :campus do |t|
      t.string :description
      t.string :street_adress
      t.string :number
      t.string :district
      t.string :city
      t.string :CEP
      t.datetime :deactivation_date

      t.timestamps
    end
  end
end
