class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.integer :user_id
      t.string :title
      t.string :extension
      t.string :mimetype
      t.string :size
      t.string :ufile

      t.timestamps
    end
  end
end
