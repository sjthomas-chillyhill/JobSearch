class AddUrlToBusiness < ActiveRecord::Migration[8.0]
  def change
    add_column :businesses, :url, :string
  end
end
