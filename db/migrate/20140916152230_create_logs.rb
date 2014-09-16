class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :count
      t.date :date

      t.timestamps
    end
  end
end
