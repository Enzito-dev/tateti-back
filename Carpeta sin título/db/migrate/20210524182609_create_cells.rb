class CreateCells < ActiveRecord::Migration[6.1]
  def change
    create_table :cells do |t|
      t.integer :turn
      t.integer :position
      t.boolean :marked, default: false
      t.references :user
      t.references :board	
      t.timestamps
    end
  end
end
