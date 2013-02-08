class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :user
      t.string :current
      t.string :max

      t.timestamps
    end
    add_index :stats, :user_id
  end
end
