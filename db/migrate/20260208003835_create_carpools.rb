class CreateCarpools < ActiveRecord::Migration[6.0]
  def change
    create_table :carpools do |t|
      t.references :begging_campus, null: false, foreign_key: true
      t.references :ending_campus, null: false, foreign_key: true

      t.timestamps
    end
  end
end
