class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :url
      t.integer :impressions
      t.integer :user_id
      t.string :image
      t.integer :views
      t.boolean :live
      t.integer :clicks
      t.string :title
      t.string :slug
      t.integer :website_id

      t.timestamps null: false
    end
  end
end
