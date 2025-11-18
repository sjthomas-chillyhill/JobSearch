class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.date :appliedOn
      t.string :position
      t.belongs_to :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
