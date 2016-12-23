class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :url
      t.integer :user_id
      t.boolean :active
      t.boolean :disabled

      t.timestamps null: false
    end
  end
end
