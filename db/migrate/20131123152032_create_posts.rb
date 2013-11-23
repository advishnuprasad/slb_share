class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.text :links
      t.string :tags
      t.references :user, index: true

      t.timestamps
    end
  end
end
