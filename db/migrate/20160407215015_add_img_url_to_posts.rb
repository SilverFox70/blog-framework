class AddImgUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :img_url, :string
  end
end
