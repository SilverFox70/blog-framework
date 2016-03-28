class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :date
      t.text :content
      t.string :category

      t.timestamps null: false
    end
  end
end
