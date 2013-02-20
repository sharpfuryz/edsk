class AddMetaToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :description, :string
    add_column :nodes, :checksum, :string
    add_column :nodes, :public, :boolean
  end
end
