class AddStatusToApplicationsV2 < ActiveRecord::Migration[8.0]
  def change
    add_column :applications, :status, :integer
  end
end
