class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :nickname
      t.string :token
      t.boolean :connected, default: false
      t.boolean :playing, default: false
      t.timestamps
    end
  end
end
