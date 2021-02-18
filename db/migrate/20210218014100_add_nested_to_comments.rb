class AddNestedToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :nested, :boolean, default: false
  end
end
