class ChangePostsToImages < ActiveRecord::Migration[5.2]
  def change
    rename_table :posts, :images
  end
end
