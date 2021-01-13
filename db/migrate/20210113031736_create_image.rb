class CreateImage < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :keyword
      t.string :url
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
