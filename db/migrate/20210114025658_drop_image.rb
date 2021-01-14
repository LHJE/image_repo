class DropImage < ActiveRecord::Migration[5.2]
  def change
    drop_table :images do |t|
      t.string :url, null: false
      t.string :keyword, null: false
      t.timestamps null: false
    end
  end
end
