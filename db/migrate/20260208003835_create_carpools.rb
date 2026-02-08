class CreateCarpools < ActiveRecord::Migration[6.0]
  def change
    create_table :carpools do |t|
      t.references :beginning_campus, null: false, foreign_key: { to_table: :campus }
      t.references :ending_campus, null: false, foreign_key: { to_table: :campus }

      t.timestamps
    end
  end
end
